/**
 * @author GrafMine
 */
package;
import pixi.plugins.app.Application;
class BaseMainView extends Application
{
	public function new():Void
	{
		super();
		_init();
	}
	
	function _init()
	{
		onUpdate = _draw;
		super.start(Application.RECOMMENDED);
	}
	
	function _draw(elapsedTime:Float):Void
	{
		TimerManagerHaxe.update();
	}
}