﻿package classes {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.Loader;		import flash.events.ProgressEvent;	import flash.events.IOErrorEvent;	import flash.events.Event;	import flash.net.URLRequest;		import com.greensock.TweenLite;			public class SlideControl extends Sprite	{				private var previous_swf:MovieClip;		private var current_swf:MovieClip;						private var tween_previous:TweenLite;		private var tween_current:TweenLite;				private var _transition:String;				private var current_num:int = 1;		private var slide_max:int = 10;								public function SlideControl()		{			// constructor code		}						public function init():void		{			loadPage( 1 );		}						public function pageLeft():void		{						if( current_swf.currentFrame == 1 && current_num > 1 )			{				current_num--;				loadPage( current_num, TransitionConstants.TRANSITION_LEFT );			}			else if( current_swf.currentFrame > 1 )			{				current_swf.gotoAndStop( current_swf.currentFrame - 1 );			}		}				public function pageRight():void		{			if( current_swf.currentFrame == current_swf.totalFrames && current_num < slide_max )			{				current_num++;				loadPage( current_num, TransitionConstants.TRANSITION_RIGHT );			}			else if( current_swf.currentFrame < current_swf.totalFrames )			{				current_swf.gotoAndStop( current_swf.currentFrame + 1 );			}		}								private function loadPage( page_num:int, transition:String = "" ):void		{			_transition = transition;						var slide_loader = new Loader( );			slide_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, preloadLoop );			slide_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, loadError );			slide_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadComplete );			slide_loader.load( new URLRequest( "slides/slide"+page_num+".swf" ) );		}									private function preloadLoop( ev:ProgressEvent ):void		{			//var perc:Number = ev.bytesLoaded / ev.bytesTotal;		}				private function loadError( ev:IOErrorEvent ):void 		{			trace( "The following error occured: " + ev );   		}							private function loadComplete( ev:Event ):void		{							ev.currentTarget.removeEventListener( ProgressEvent.PROGRESS, preloadLoop );			ev.currentTarget.removeEventListener( IOErrorEvent.IO_ERROR, loadError );			ev.currentTarget.removeEventListener( Event.COMPLETE, loadComplete );									var new_loader:Loader = ev.currentTarget.loader as Loader;						if( previous_swf )				removeChild( previous_swf );							previous_swf = current_swf;															current_swf = ev.currentTarget.content as MovieClip	;						current_swf.visible = false;						addChild( current_swf );						determineTransition();		}						private function determineTransition():void		{			switch( _transition )			{				case TransitionConstants.TRANSITION_LEFT:					transitionLeft();					break;				case TransitionConstants.TRANSITION_RIGHT:					transitionRight();					break;				case TransitionConstants.TRANSITION_INSTANT:				default :					transitionInstant();			}		}						private function transitionRight():void		{							previous_swf.x = 0;			current_swf.x = stage.stageWidth;			current_swf.visible = true;			current_swf.stop();						tween_previous = new TweenLite( previous_swf, .3, { x: -stage.stageWidth } );			tween_current = new TweenLite( current_swf, .3, { x: 0 } );		}						private function transitionLeft():void		{							previous_swf.x = 0;			current_swf.x = -stage.stageWidth;			current_swf.visible = true;			current_swf.gotoAndStop( current_swf.totalFrames );						tween_previous = new TweenLite( previous_swf, .3, { x: stage.stageWidth } );			tween_current = new TweenLite( current_swf, .3, { x: 0 } );		}						private function transitionInstant():void		{			current_swf.visible = true;			current_swf.stop();						if( previous_swf )				previous_swf.visible = false;		}			}}