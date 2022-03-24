using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;
using ProyectoServicioSocial.Models;
using ProyectoServicioSocial.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;

namespace ProyectoServicioSocial.Areas.Usuarios.Pages.Account
{
    public class LoginModel : PageModel
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly ServicioSocialContext _ss;
        private readonly ILogger<LoginModel> _logger;
        
        public LoginModel(
            UserManager<IdentityUser> userManager, ServicioSocialContext ss, ILogger<LoginModel> logger)
        {
            _userManager = userManager;
            _logger = logger;
            _ss = ss;
        }    

        public IEnumerable<TipoUsuario> roles { get; set; }
        [BindProperty]
        public InputModel Input { get; set; }
        public string ReturnUrl { get; set; }
        [TempData]

        public string ErrorMessage { get; set; }
        
        public class InputModel
        {
            [Required(ErrorMessage ="El nombre de usuario es obligatorio")]
            [StringLength(13,ErrorMessage ="La longitud {0} mínima debe ser {2} y la máxima{1}",MinimumLength = 6)]
            [Display(Name ="UserName")]

            public string UserName { get; set; }

            [Required]
            [DataType(DataType.Password)]

            public string Password { get; set; }

            [Display(Name = "Remember me?")]
            public bool RememberMe { get; set; }

        }

        public void OnGet()
        {
        }

        public async Task<IActionResult> OnPostAsync(string returnUrl = null)
        {
            returnUrl = returnUrl ?? Url.Content("/Principal/Principal?area=Principal");

            if (ModelState.IsValid)
            {

                ProyectoServicioSocial.Models.Usuarios user1 = null;
                var user = await _userManager.FindByNameAsync(Input.UserName);
                roles = _ss.TipoUsuario.ToList();
                foreach (var rol in roles)
                {
                    user1 = await _ss.Usuarios.FindAsync(user.UserName,rol.Id);
                    if (user1 != null)
                        break;
                }
                if (user == null || user1 == null)
                        return StatusCode(StatusCodes.Status401Unauthorized, "Incorrect username or password");

                bool passwordOK = await _userManager.CheckPasswordAsync(user, Input.Password);

                if (!passwordOK)
                    return StatusCode(StatusCodes.Status401Unauthorized, "Incorrect username or password");


                if ((user != null && passwordOK) && user1.TipoUsuarioId == 1)
                {
                    _logger.LogInformation("User logged in..");
                    return LocalRedirect(returnUrl);
                }

                else if ((user!=null && passwordOK) && user1.TipoUsuarioId != 1) 
                {
                    returnUrl = Url.Content("/Alumnos/Alumnos?area=Alumnos");
                    _logger.LogInformation("User logged in.");
                    return LocalRedirect(returnUrl);

                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                    return Page();
                }
            }

            //if we got this far, something failed, redisplay form
            return Page();
        }


    }
}
