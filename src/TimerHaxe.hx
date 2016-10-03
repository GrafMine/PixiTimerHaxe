/**
 * @author GrafMine
 */
package ;
import pixi.interaction.EventEmitter;
class TimerHaxe extends EventEmitter
{
	public static var STOP:String                   = "stop";
	public static var START:String                  = "start";
	public static var UPDATE:String                 = "update";
	public static var END:String                    = "end";
	public static var REPEAT:String                 = "repeat";

	public var time:Int;
	public var active:Bool;
	public var isEnded:Bool;
	public var isStarted:Bool;
	public var expire:Bool;
	public var delay:Float;
	public var repeat:Float;
	public var loop:Bool;
	
	private var _delayTime:Float;
	private var _elapsedTime:Float;
	private var _repeat:Float;

	public function new(time:Int):Void
	{
		super();
		this.time = time;
		
		active = false;
		isEnded = false;
		isStarted = false;
		expire = false;
		delay = 0;
		repeat = 0;
		loop = false;
		
		_delayTime = 0;
		_elapsedTime = 0;
		_repeat = 0;
	}
	
	public function remove():TimerHaxe
	{
		TimerManagerHaxe.removeTimer(this);
		return this;
	}
	
	public function start():TimerHaxe
	{
		active = true;
		return this;
	}
	
	public function stop():TimerHaxe
	{
		active = false;
		this.emit(STOP, _elapsedTime);
		return this;
	}
	
	public function reset():TimerHaxe
	{
		_elapsedTime = 0;
		_repeat = 0;
		_delayTime = 0;
		isStarted = false;
		isEnded = false;
		return this;
	}
	
	public function update(delta, deltaMS)
	{
		if(!active) return;
		
		if(delay > _delayTime)
		{
			_delayTime += deltaMS;
			return;
		}
		
		if(!isStarted)
		{
			isStarted = true;
			emit(START, _elapsedTime);
		}
		
		if(time > _elapsedTime)
		{
			var t = _elapsedTime + deltaMS;
			var ended:Bool = (t >= time);
			
			_elapsedTime = ended ? time : t;
			emit(UPDATE, _elapsedTime, delta);
			
			if(ended)
			{
				if(loop || repeat > _repeat)
				{
					_repeat++;
					emit(REPEAT, _elapsedTime, _repeat);
					_elapsedTime = 0;
					return;
				}
			
				isEnded = true;
				active = false;
				emit(END, this._elapsedTime);
			}
		}
	}
}
