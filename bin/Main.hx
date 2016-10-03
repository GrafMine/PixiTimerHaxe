/**
 * @author GrafMine
 */
package;
import js.Browser;
class Main
{
	static function main():Void
	{
		Browser.window.onload = function() new Main();
	}
	
	public function new():Void
	{
		new BaseMainView();
		useSample();
	}
	
	private function useSample():Void
	{
		var timer:TimerHaxe = TimerManagerHaxe.createTimer(1);
		timer.loop = true;
		timer.on(TimerHaxe.REPEAT, onRepeat);
		timer.start();
	}
	
	private function onRepeat(elapsedTime:Float, repeat:Int):Void
	{
		trace(elapsedTime,repeat);
	}
}