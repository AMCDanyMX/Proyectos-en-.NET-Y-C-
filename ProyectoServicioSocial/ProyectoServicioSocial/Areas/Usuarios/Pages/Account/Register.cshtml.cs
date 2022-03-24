using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using static Microsoft.AspNetCore.Identity.UI.V3.Pages.Account.Internal.ExternalLoginModel;
using Microsoft.AspNetCore.Identity.UI.V4.Pages.Internal;
using Microsoft.AspNetCore.Identity;
using ProyectoServicioSocial.Data;
using ProyectoServicioSocial.Models;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Identity.UI.V3.Pages.Account.Internal;

namespace ProyectoServicioSocial.Areas.Usuarios.Pages.Account
{
    public class RegisterModel : PageModel
    {

        private UserManager<IdentityUser> _userManager;
        private ServicioSocialContext _ss;
        private readonly ILogger<LoginModel> _logger;
        public IEnumerable<TipoUsuario> roles { get; set; }


        public RegisterModel(UserManager<IdentityUser> userManager, ServicioSocialContext ss,ILogger<LoginModel> logger){
            _userManager = userManager;
            _ss = ss;
            _logger = logger;
        }
        public void OnGet(){
            roles = _ss.TipoUsuario.ToList();
        }
        [BindProperty]

        public InputModel Input { get; set; }
        public class InputModel
        {
            [Required(ErrorMessage = "El nombre de usuario es obligatorio")]
            [StringLength(13, ErrorMessage = "La longitud {0} m�nima debe ser {2} y la m�xima {1} ", MinimumLength = 6)]
            [Display(Name = "UserName")]
            public string UserName { get; set; }
            [Required(ErrorMessage = "El Password es obligatorio")]
            [StringLength(100, ErrorMessage = "El {0}  debe tener una longitud m�nima {2} y una m�xima de {1} ", MinimumLength = 6)]
            [DataType(DataType.Password)]
            [Display(Name = "Password")]
            public string Password { get; set; }

            [DataType(DataType.Password)]
            [Display(Name = "Confirm password")]
            [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
            public string ConfirmPassword { get; set; }
            public string ErrorMessage { get; set; }
            [Required(ErrorMessage="El tipo de usuario esobligatiorio")]
            public int TipoUsuarioId { get; set; }
        }
        public async Task<IActionResult> OnPost(){
            if (ModelState.IsValid){
                //Ingresa los datos
                //crear un objeto que retorna un listado de username
                var userlist = _userManager.Users.Where(u => u.UserName.Equals(Input.UserName)).ToList();
                if (userlist.Count.Equals(0)){
                    var user = new ProyectoServicioSocial.Models.Usuarios() {
                        UserName = Input.UserName,
                        TipoUsuarioId = Input.TipoUsuarioId
                    };
                    var result = await _userManager.CreateAsync(user, Input.Password);
                    if (result.Succeeded) {
                        Input = new InputModel { ErrorMessage = Input.UserName + "se registró" };
                        _logger.LogInformation("User logger in.");
                        if (user.TipoUsuarioId==1)
                            return Redirect("/Principal/Principal?area=Principal");
                        else
                            return Redirect("/Alumnos/Alumnos/?area=Alumnos");
                    }
                    else {
                        foreach (var item in result.Errors) {
                            Input = Input = new InputModel { ErrorMessage = item.Description };
                        }
                    }
                    
                }
                else{
                    Input = new InputModel { ErrorMessage = "El" + Input.UserName + "ya está registrado" };

                }
           

            }
            else{
                ModelState.AddModelError("Input.UserName", "Error de lado del servidor, datos no validos");
            }
            roles = _ss.TipoUsuario.ToList();
            return Page();
        }
    }
}
