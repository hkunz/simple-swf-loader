//
//  HkunzLogoProgress
//
//  Created by Harry Kunz on 2010-11-27.
//  Copyright (c) 2010 hkunz. All rights reserved.
//

package {
	
	import com.hkunz.display.utils.Polygon;
	import com.hkunz.symbols.Logo;
	import com.hkunz.interfaces.IProgressable;
	import com.hkunz.text.Text;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	import flash.events.Event;
	import com.hkunz.log.Log;
	
	public class HkunzLogoProgress extends Sprite implements IProgressable{

		//================================================================== 
		// PUBLIC PROPERTIES
		
		public static const RADIUS:int = 60;
		
		//================================================================== 
		// PROTECTED PROPERTIES
		
		protected var _text:Text;
		protected var _prefix:String;
		protected var _progress:DisplayObject;		//HkunzLogoProgress graphic, Use Scale9Sprite or manually set scale9Grid property of the display object
		
		//================================================================== 
		// CONSTRUCTOR

		public function HkunzLogoProgress(text:Text = null, prefix:String = "Loading..."){

			_text = text;
			
			if(_text){
				_prefix = prefix;
				addChild(_text);
			}
			
			
			
			var sides:int = 50;
			
			var glowHolder:Polygon = new Polygon(sides, RADIUS, {fillColor:0xFFFFFF});
			var poly:Polygon = new Polygon(sides, RADIUS+20, {fillColor:0x00FF00, angle:0});
			var logoBg:Logo = new Logo();
			var logo:Logo = new Logo();
			
			poly.x = RADIUS;
			poly.y = RADIUS;
			glowHolder.x = RADIUS;
			glowHolder.y = RADIUS;
			
			logoBg.alpha = 0.2;
			logoBg.width = RADIUS*2;
			logoBg.height = RADIUS*2;
			logo.width = logoBg.width;
			logo.height = logoBg.height;
			logo.mask = poly;
			
			glowHolder.filters = [new GlowFilter(0x000000, 0.3, 30, 30, 1)];
			logo.filters = [new GlowFilter(0x000000, 0.7, 30, 30, 1)];
			
			_progress = poly;
			
			this.percent = 0;
			
			addChild(glowHolder);
			addChild(logoBg);
			addChild(logo);
			addChild(poly);
		}

		//================================================================== 
		// PUBLIC METHODS

		//================================================================== 
		// PROTECTED METHODS

		//================================================================== 
		// PRIVATE METHODS

		//================================================================== 
		// SET METHODS

		public function set percent(value:Number):void{
			//_progress.width = value*_maxWidth;
			(_progress as Polygon).angle = value*360;
			if(_text){
				_text.text = _prefix + int(value*100) + "%";
			}
		}
		
		//================================================================== 
		// GET METHODS
		
		public function get barWidth():Number{
			return _progress.width;
		}
	}
}