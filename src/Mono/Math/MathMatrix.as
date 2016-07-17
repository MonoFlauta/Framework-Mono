package Mono.Math
{
	import Mono.Mono;

	public class MathMatrix
	{
		public function MathMatrix()
		{
			
		}
		
		/** Adds two matrixes.
		 * 
		 * @param matriz1 First matrix
		 * @param matriz2 The matrix that will be added to the firts matrix
		 * 
		 * @return Returns the resulting matrix */
		public static function add(matriz1:Array, matriz2:Array):Array
		{
			var resultado:Array = matriz1;
			for(var i:int = 0; i<matriz1.length; i++)
			{
				if(matriz1[i] is int || matriz2[i] is int)
				{
					Main.mono.reportError("The matrix must be arrays inside the arrays, in the case of having a linear matrix it must be written in the following way: [[x1], [x2], ... [xn]]", "Math", "MathMatrix", "sumar");
				}
				else
				{
					if(matriz1[i].length != matriz2[i].length || matriz1.length != matriz2.length) 
					{
						Main.mono.reportError("The matrixes must have equal quantity of columns as rows there must be no null values", "Math", "MathMatrix", "sumar");
					}
				}
				for(var j:int = 0; j<matriz1[i].length; j++) 
				{
					resultado[i][j]=matriz1[i][j]+matriz2[i][j];
				}
			}
			return resultado; 
		}
		
		/** Multiplies all the matrix by a value.
		 * 
		 * @param matriz Matrix
		 * @param k Value
		 * 
		 * @return Returns the resulting matrix */
		public static function productByScale(matriz:Array, k:int):Array
		{
			for (var i:int = 0; i < matriz.length; i++) 
			{
				if(matriz[i] is int) 
				{
					Main.mono.reportError("The matrix must be arrays inside the arrays, in the case of having a linear matrix it must be written in the following way: [[x1], [x2], ... [xn]]", "Math", "MathMatrix", "productoPorUnEscalar");
				}
				for (var j:int = 0; j<matriz[i].length; j++)
				{
					matriz[i][j] = matriz [i][j]*k;
				}
			}
			return matriz; 
		}
	}
}