﻿package classes{	import flash.display.Sprite;	import net.hires.debug.Stats;	public class FrameRate extends Sprite	{		private var theStats:Sprite = new Stats();				public function FrameRate()		{			addChild( theStats );		}			}}