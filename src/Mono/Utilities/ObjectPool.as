package Mono.Utilities
{
	import Mono.Mono;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class ObjectPool
	{
		private var _pools:Dictionary;
		
		public function ObjectPool()
		{
			_pools = new Dictionary(); 
		}
		
		/**Returns an object of the pool. 
		 * 
		 * @param type Type of the object
		 * @return Returns the desired object
		 * 
		 * */
		public function getObj(type:Class):*
		{
			var pool:Array = getPool(type);
			if(pool.length>0) 
			{
				return pool.pop(); 
			}
			else
			{
				return new type(); 
			}
		}
		
		/**Creates an initial stock.
		 * 
		 * @param type Type of the object
		 * @param amount Ammount to be created
		 * 
		 * */
		public function createAmount(type:Class, amount:int):void
		{
			var pool:Array = getPool(type); 
			for(var i:int=1; i<amount; i++)
			{
				pool.push(new type()); 
			}
		}
		
		/**Saves the object in the object pool.
		 * 
		 * @param object Object to be saved
		 * @param type Type of the object. (Default: null)
		 * 
		 * */
		public function disposeObject(object:*, type:Class = null):void
		{
				if(!type)
				{
					type = getDefinitionByName(getQualifiedClassName(object)) as Class;
				}
				var pool:Array = getPool(type); 
				pool.push(object);
		}
		
		/**Search the array and returns it with all the objects inside. 
		 * 
		 * @param type Type of the object
		 * @return Returns the array with the list of objects
		 * 
		 * */
		private function getPool(type:Class):Array
		{
			return type in _pools ? _pools[type] : _pools[type] = new Array(); 
		}
	}
}