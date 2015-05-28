﻿package  
{	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.desktop.NativeApplication;
	import Constants;
	import DotBoard;
	public class Engine extends MovieClip
	{
		private var dotBoard:DotBoard;
		private var menu:MenuScreen;
		public function Engine() 
		{
			setupConstants();
			setupMenu();
		}
		public function setupMenu()
		{
			menu = new MenuScreen();
			addEventListeners();
			addChild(menu);
		}
		public function eventHandler(e:Event)
		{
			var string:String = trim(e.target.text);
			removeChild(menu);
			removeListeners();
			switch(string)
			{
				case "One Player":
					dotBoard = new DotBoard(new Player(), new AI());
					dotBoard.addEventListener(Constants.GO_BACK_MENU_EVENT, removeGame);
					addChild(dotBoard);
					break;
				case "Two Players":
					dotBoard = new DotBoard(new Player(), new Player());
					dotBoard.addEventListener(Constants.GO_BACK_MENU_EVENT, removeGame);
					addChild(dotBoard);
					break;
				case "AI Game":
					dotBoard = new DotBoard(new AI(), new AI());
					dotBoard.addEventListener(Constants.GO_BACK_MENU_EVENT, removeGame);
					addChild(dotBoard);
					break;
				case "Exit":
					NativeApplication.nativeApplication.exit(); 
					break;
			}
		}
		function trim(s:String):String
		{
		  return s.replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );
		}
		public function setupConstants()
		{
			Constants.NUMBER_OF_DOTS = 8;
			Constants.SCREEN_HEIGHT = stage.stageHeight;
			Constants.SCREEN_WIDTH = stage.stageWidth;
			Constants.DOT_SIZE = (new DotAsset()).width;
			Constants.DOT_MAX_NEIGHBOURS = 4;
		}
		public function removeGame(e:Event)
		{
			removeChild(dotBoard);
			addEventListeners();
			addChild(menu);
		}
		public function removeListeners()
		{
			menu.exitGame.removeEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
			menu.twoPlayerGame.removeEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
			menu.onePlayerGame.removeEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
			menu.AIGame.removeEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
		}
		public function addEventListeners()
		{
			menu.exitGame.addEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
			menu.twoPlayerGame.addEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
			menu.onePlayerGame.addEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
			menu.AIGame.addEventListener(MouseEvent.MOUSE_DOWN, eventHandler);
		}
	}
	
}