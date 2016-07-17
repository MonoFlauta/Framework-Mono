package Mono.Utilities
{
	import Mono.Mono;
	import Mono.Utilities.Complements.Nod;
	import Mono.Visual.Artist;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Dijkstra
	{
		public var existeCamino:Boolean = false; 
		public var graficar:Boolean = false; 
		public var nodosCamino:Vector.<Nod>;
		
		private var _nodos:Vector.<Nod>;
		private var _nodosAbiertos:Vector.<Nod>;
		private var _nodosCerrados:Vector.<Nod>;
		private var _nodosSinCerrar:Vector.<Nod>;
		private var _nodoInicial:Nod;
		private var _nodoFinal:Nod;
		private var _vision:Number;
		private var _posFinal:Point;
		
		public function Dijkstra()
		{
			_nodos = new Vector.<Nod>(); 
			_nodosAbiertos = new Vector.<Nod>(); 
			_nodosCerrados = new Vector.<Nod>(); 
			nodosCamino = new Vector.<Nod>();
		}
		
		/** Executes Dijkstra.
		 * 
		 * @param initialPosition The initial position;
		 * @param finalPosition The final position;
		 * 
		 *  */
		public function executeDijkstra(initialPosition:Point, finalPosition:Point, visionDistance:Number):void
		{
			var i:int; 
			var origen:Point; 
			var destino:Point; 
			var distancia:Number; 
			
			_vision = visionDistance; 
			_posFinal = finalPosition;
			
			for(i = 0; i<_nodos.length-1; i++)
			{
				_nodos[i].fatherNode = null; 
				_nodos[i].nextNode = null; 
				_nodos[i].distanceToFather = Infinity; 
			}
			_nodosAbiertos.splice(0, _nodosAbiertos.length); 
			nodosCamino.splice(0, nodosCamino.length); 
			_nodosCerrados.splice(0, _nodosCerrados.length);
			_nodoInicial = null;
			_nodoFinal = null;
			
			for(i = 0; i<_nodos.length-1; i++) 
			{
				origen = initialPosition;
				destino = _nodos[i].position; 
				distancia = Point.distance(origen, destino);
				if(distancia<=visionDistance)
				{
					if(_nodoInicial == null) 
					{
						_nodoInicial = _nodos[i]; 
						_nodoInicial.distanceToFather = distancia; 
					}
					else if(_nodoInicial.distanceToFather > distancia)
					{
						_nodoInicial.distanceToFather = Infinity;
						_nodoInicial = _nodos[i];
						_nodoInicial.distanceToFather = distancia;
					}
				}
				_nodoInicial.fatherNode = null; 
				origen = finalPosition; 
				distancia = Point.distance(origen, destino);
				if(distancia<=visionDistance)
				{
					if(_nodoFinal == null) 
					{
						_nodoFinal = _nodos[i];
						_nodoFinal.distanceToFather = distancia;
					}
					else if(_nodoFinal.distanceToFather > distancia)
					{
						_nodoFinal.distanceToFather = Infinity;
						_nodoFinal = _nodos[i]; 
						_nodoFinal.distanceToFather = distancia; 
					}
				}
			}
			
			if(_nodoInicial != null && _nodoFinal != null)
			{
				_nodosSinCerrar = _nodos; 
				_nodosAbiertos.push(_nodoInicial); 
				explorarNodo(_nodoInicial); 
			}
			else
			{
				existeCamino = false; 
				Main.mono.reportInformation("Couldn't find a path", "Utilities", "Dijkstra", "executeDijkstra");
			}
		}
		
		/** Explore node.
		 * 
		 * @param nodo Node to explore
		 * 
		 *  */
		private function explorarNodo(nodo:Nod):void
		{
			var i:int; 
			var posNodo:Point =nodo.position; 
			var posPosible:Point; 
			for(i = 0; i<_nodosSinCerrar.length-1; i++) 
			{
				if(_nodosSinCerrar[i]!=nodo)
				{
					posPosible = _nodosSinCerrar[i].position; 
					if(Point.distance(posPosible, posNodo) <= _vision) 
					{
						if(!vectorContainsNode(_nodosSinCerrar[i], _nodosAbiertos)) 
						{
							_nodosSinCerrar[i].distanceToFather = Point.distance(posPosible, posNodo)+nodo.distanceToFather; 
							_nodosSinCerrar[i].fatherNode = nodo; 
							_nodosAbiertos.push(_nodosSinCerrar[i]); 
						}
						if(Point.distance(posPosible, posNodo)+nodo.distanceToFather < _nodosSinCerrar[i].distanceToFather)
						{
							_nodosSinCerrar[i].distanceToFather = Point.distance(posPosible, posNodo)+nodo.distanceToFather; 
							_nodosSinCerrar[i].fatherNode = nodo; 
						}
					}
				}
			}
			_nodosAbiertos=removeNode(nodo, _nodosAbiertos);
			_nodosSinCerrar=removeNode(nodo, _nodosSinCerrar); 
			_nodosCerrados.push(nodo); 
			if(nodo == _nodoFinal) 
			{
				
				existeCamino = true; 
				nodosCamino.push(_nodoFinal);
				
				var aux:Nod = _nodoFinal.fatherNode; 
				var auxN:Nod = _nodoFinal; 
				
				while(aux != _nodoInicial)
				{
					if(graficar) 
					{
						var lin:Sprite = new Sprite(); 
						lin = Artist.line(aux.position.x, aux.position.y, auxN.position.x, auxN.position.y, 3, 0x00ff00, 1); 
						Main.mono.mainStage.addChild(lin); 
					}
					nodosCamino.push(aux); 
					auxN = aux;
					aux = aux.fatherNode; 
				}
				Main.mono.reportInformation("A path was found", "Utilities", "Dijkstra", "exploreNode");
			}
			else if(_nodosAbiertos.length>0)
			{
				var nodoExplorar:Nod = nodo; 
				var fitness:Number = Infinity; 
				posPosible = _nodosAbiertos[0].position; 
				for(i = 0; i<_nodosAbiertos.length-1; i++) 
				{
					var d:Number = Point.distance(nodo.position, posPosible) + _nodosAbiertos[i].distanceToFather; 
					if(d < fitness) 
					{
						fitness = d; 
						nodoExplorar = _nodosAbiertos[i]; 
					}
				}
				explorarNodo(nodoExplorar); 
			}
			else
			{
				existeCamino = false; 
				Main.mono.reportInformation("Couldn't find a path", "Utilities", "Dijkstra", "exploreNode");
			}
		}
		
		/** Add a node.
		 * 
		 * @param p Position of the node
		 * 
		 *  */
		public function agregarNodo(p:Point):void
		{
			var n:Nod = new Nod(p, graficar); 
			_nodos.push(n); 
		}
		
		/** Removes a node based on its position.
		 * 
		 * @param p Point where the node is
		 * 
		 *  */
		public function containsNode(p:Point):void
		{
			for(var i:int = 0; i<_nodos.length-1; i++) 
			{
				if(_nodos[i].position == p) 
				{
					_nodos.splice(i, 1);
				}
			}
		}
		
		/** Removes the node.
		 * 
		 * @param nodo Node
		 * @param vect Vector
		 * 
		 * @return Returns the vector whitout the node
		 *  */
		private function removeNode(nodo:Nod, vect:Vector.<Nod>):Vector.<Nod>
		{
			for(var i:int = 0; i<vect.length-1; i++)
			{
				if(vect[i] == nodo)
				{
					vect.splice(i, 1);
					i = vect.length;
				}
			}
			
			return vect;
		}
		
		/** Tells if the vector has the node.
		 * 
		 * @param nodo Node
		 * @param vect Vector
		 * 
		 * @return Returns if it has it
		 *  */
		private function vectorContainsNode(nodo:Nod, vect:Vector.<Nod>):Boolean
		{
			var result:Boolean = false;
			for(var i:int = 0; i<vect.length-1; i++) 
			{
				if(vect[i] == nodo) 
				{
					return true;
				}
			}
			return result;
		}
	}
}