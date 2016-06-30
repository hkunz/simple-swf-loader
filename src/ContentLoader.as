//
//  ContentLoader
//
//  Created by Harry Kunz on 2010-10-24.
//  Copyright (c) 2010 hkunz. All rights reserved.
//

package{
	
	import com.hkunz.components.SimpleProgressBar;
	import com.hkunz.net.SWFLoader;
	import com.hkunz.text.Text;
	import com.hkunz.utils.stageInit;
	
	import flash.external.ExternalInterface;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	public class ContentLoader extends SWFLoader{

		//================================================================== 
		// PUBLIC PROPERTIES

		//================================================================== 
		// PROTECTED PROPERTIES
		
		protected var _progressWidth:int;
		protected var _progressHeight:int;
		protected var _percText:Text;

		//================================================================== 
		// CONSTRUCTOR

		public function ContentLoader(){
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
			
			_progress = new SimpleProgressBar(_progressWidth, _progressHeight, _percText, 0x000);
			_progress.x = (_width - (_progress as SimpleProgressBar).maxWidth)*0.5;
			_progress.y = (_height - (_progress as SimpleProgressBar).height)*0.5;
			
			_percText.y = _progress.y + 2;

			super.render();
			
			//addChild(_percText);
		}

		protected override function onLoadProgress(percLoad:Number):void{
			super.onLoadProgress(percLoad);
			if(_progress){
				_percText.x = _progress.x + (_progress as SimpleProgressBar).barWidth - _percText.width;
			}
			_percText.visible = true;
		}

		//================================================================== 
		// PRIVATE METHODS

		//================================================================== 
		// SET METHODS

		//================================================================== 
		// GET METHODS

	}
}