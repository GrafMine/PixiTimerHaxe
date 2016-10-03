/**
 * @author GrafMine
 */
package ;
import haxe.Timer;
class TimerManagerHaxe
{
	static var timers:Array<TimerHaxe> = new Array<TimerHaxe>();
	static var _timersToDelete:Array<TimerHaxe> = new Array<TimerHaxe>();
	static var _last:Float = 0;
	
	public static function update(?delta:Float):Void
	{
		var deltaMS:Float;
		if(delta == null && delta != 0)
		{
			deltaMS = getDeltaMS();
			delta = deltaMS / 1000;
		}
		else
		{
			deltaMS = delta * 1000;
		}

		for(i in 0...timers.length)
		{
			var timer:TimerHaxe = timers[i];
			if(timer.active)
			{
				timer.update(delta, deltaMS);
				if(timer.isEnded && timer.expire)
				{
					timer.remove();
				}
			}
		}
		
		if(_timersToDelete.length > 0)
		{
			for(i in 0..._timersToDelete.length)
			{
				remove(_timersToDelete[i]);
			}
			
			while(_timersToDelete.length > 0)
			{
				remove(_timersToDelete[0]);
			}
		}
	}
	
	public static function removeTimer(timer:TimerHaxe):Void
	{
		_timersToDelete.push(timer);
	}
	
	public static function createTimer(time:Int):TimerHaxe
	{
		var timer = new TimerHaxe(time);
		timers.push(timer);
		return timer;
	}
	
	private static function remove(timer:TimerHaxe):Void
	{
		var index = timers.indexOf(timer);
		if(index > 0)
		{
			timers.splice(index, 1);
		}
	}
	
	private static function getDeltaMS():Float
	{
		if(_last == 0)
		{
			_last = Timer.stamp();
		}
		var now = Timer.stamp();
		var deltaMS:Float = now - _last;
		_last = now;

		return deltaMS;
	}
}
