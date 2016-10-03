/**
 * @author GrafMine
 */
package;
import js.html.CanvasElement;
import pixi.core.text.Text;
import pixi.core.renderers.SystemRenderer;
import pixi.plugins.app.Application;
class BaseMainView extends Application
{
	var _renderer:SystemRenderer;
	var meter:Dynamic;
	var textField:Text;
	var canvasCustom:CanvasElement;
	
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