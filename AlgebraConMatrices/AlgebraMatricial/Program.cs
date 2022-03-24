using System;

namespace AlgebraMatricial
{
    class Program
    {
        public static void imprimirMatriz(int[,] matriz, int filas, int columnas) {
            for (int i = 0; i < filas; i++)
            {
                for (int j = 0; j < columnas; j++)
                {
                    Console.Write(matriz[i, j]+" ");
                }
                Console.Write("\n");
            }
            Console.Write("\n");
        }
        public static int[,] SumaMatrices(int[,] matriz1, int reng1, int col1,int[,] matriz2,int reng2,int col2)
        {
            if (reng1 == reng2 && col1 == col2)
            {
                int[,] sumado = new int[reng1, col2];
                for(int renglones = 0; renglones < reng1; renglones++)
                {
                    for (int columnas = 0; columnas < col1; columnas++)
                    {
                        sumado[renglones, columnas] = matriz1[renglones, columnas] + matriz2[renglones, columnas];
                    }
                }
                return sumado;    
            }
            else 
            {
                return null;
            }
        }
        public static int[,] multiplicarEscalar (int[,] matriz, int reng, int col, int escalar)
        {
            int[,] multiplicado = new int[reng, col];
            for (int renglones = 0; renglones < reng; renglones++)
            {
                for (int columnas = 0; columnas < col; columnas++)
                {
                    multiplicado[renglones, columnas] = matriz[renglones, columnas] * escalar;
                }
            }
            return multiplicado;
        }
        public static int[,] multiplicarMatrices(int[,] matriz1, int reng1, int col1, int[,] matriz2, int reng2, int col2)
        {
            if (col1 != reng2) {
                return null;
            }
            else 
            {
                int[,] multiplicada = new int[reng1, col2];
                inicializarMatriz(multiplicada,reng1,col2);
                int valor1;
                int valor2;
                int valor3;
                for(int renglones1 = 0; renglones1 < reng1; renglones1++)
                {
                    for(int columnas2=0; columnas2 < col2; columnas2++)
                    {
                        for(int columnas1=0; columnas1<col1; columnas1++)
                        {
                            valor1 = matriz1[renglones1, columnas1];
                            valor2 = matriz2[columnas1, columnas2];
                            valor3 = multiplicada[renglones1, columnas2];
                            multiplicada[renglones1, columnas2] = valor3 + (valor1 * valor2);
                        }
                    }
                }
                return multiplicada;
            }
        }
        public static void inicializarMatriz(int[,] matriz,int filas, int columnas)
        {
            for(int i =0; i < filas; i++)
            {
                for(int j = 0; i < columnas; i++)
                {
                    matriz[i, j] = 0;
                }
            }
        }
        static void Main(string[] args)
        {
            int[,] matriz1 = new int[3, 3];
            matriz1[0, 0] = 1;
            matriz1[0, 1] = 2;
            matriz1[0, 2] = 3;
            matriz1[1, 0] = 4;
            matriz1[1, 1] = 5;
            matriz1[1, 2] = 6;
            matriz1[2, 0] = 7;
            matriz1[2, 1] = 8;
            matriz1[2, 2] = 9;
            int[,] matriz2 = new int[3, 3];
            matriz2[0, 0] = 9;
            matriz2[0, 1] = 8;
            matriz2[0, 2] = 7;
            matriz2[1, 0] = 6;
            matriz2[1, 1] = 5;
            matriz2[1, 2] = 4;
            matriz2[2, 0] = 3;
            matriz2[2, 1] = 2;
            matriz2[2, 2] = 1;
            int [,] matrizSumada = SumaMatrices(matriz1, 3, 3, matriz2, 3, 3);
            Console.Write("Sumando matriz1 con matriz2\n");
            imprimirMatriz(matrizSumada,3,3);
            int[,] multiplicadoEscalar = multiplicarEscalar(matriz1, 3, 3, 2);
            Console.Write("Multiplicar escalar\n");
            imprimirMatriz(multiplicadoEscalar,3,3);
            Console.Write("Multiplicando 2 matrices \n");
            int[,] mult = multiplicarMatrices(matriz1, 3, 3, matriz2, 3, 3);
            imprimirMatriz(mult,3,3);

        }
    }
}
