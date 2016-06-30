//
//  FlashLoader
//
//  Created by Harry Kunz on 2010-10-24.
//  Copyright (c) 2010 hkunz. All rights reserved.
//

package{
	
	import com.hkunz.display.utils.createRect;
	import com.hkunz.net.SWFLoader;
	import com.hkunz.text.Text;
	import com.hkunz.utils.stageInit;
	
	import flash.external.ExternalInterface;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	
	public class FlashLoader extends SWFLoader{

		//================================================================== 
		// PUBLIC PROPERTIES

		//================================================================== 
		// PROTECTED PROPERTIES
		
		protected var _progressWidth:int;
		protected var _progressHeight:int;
		protected var _percText:Text;
		protected var _plastic:Sprite;
		
		//================================================================== 
		// CONSTRUCTOR

		public function FlashLoader(){
			super();
		}

		//================================================================== 
		// PUBLIC METHODS
		
		//================================================================== 
		// PROTECTED METHODS

		protected override function initialise():void{
			stageInit(stage, StageAlign.TOP_LEFT, StageScaleMode.NO_SCALE, "best", 100);
			_url = stage.loaderInfo.parameters["url"];
			_progressWidth = stage.loaderInfo.parameters["pWidth"] || 200;
			_progressHeight = stage.loaderInfo.parameters["pHeight"] || 20;
			super.initialise();
		}
		
		protected override function render():void{
			
			_percText = new Text();
			_percText.color = 0xFFFFFF;
			_percText.size = 15;
			_percText.autoSize = Text.AUTOSIZE_LEFT;
			_percText.visible = false;
			
			_progress = new HkunzLogoProgress(_percText);
			_progress.x = (_width - (_progress as HkunzLogoProgress).width)*0.5;
			_progress.y = (_height - (_progress as HkunzLogoProgress).height)*0.5;
			
			_percText.y = _progress.y + 2;
			
			_plastic = createRect(_width, _height, {fillColor:0xFFFFFF, fillAlpha:1});
			_plastic.mouseChildren = true;
			addChild(_plastic);
			super.render();
			
			//addChild(_percText);
		}

		protected override function onLoadProgress(percLoad:Number):void{
			super.onLoadProgress(percLoad);
			if(_progress){
				_percText.x = _progress.x + (_progress as HkunzLogoProgress).barWidth - _percText.width;
			}
			_percText.visible = true;
		}
		
		protected override function onLoadComplete(loader:Object):void{
			var alpha:Number = 1;
			var thiz:Object = this;
			(_progress as DisplayObject).addEventListener(Event.ENTER_FRAME, function(event:Event):void{
				_progress.alpha = alpha < 0 ? 0 : alpha;
				_plastic.alpha = _progress.alpha;
				alpha -= 0.03;
				if(alpha < -0.2){
					(_progress as DisplayObject).removeEventListener(Event.ENTER_FRAME, arguments.callee);
					/*while(thiz.numChildren > 0){ 
						thiz.removeChildAt(0);
					}*/
					thiz.removeChild(_plastic);
					thiz.removeChild(_progress);
				}
				_progress.percent = alpha;
			});
			thiz.addChildAt(_loader.content, 0);
		}
		
		//================================================================== 
		// PRIVATE METHODS

		//================================================================== 
		// SET METHODS

		//================================================================== 
		// GET METHODS

	}
}