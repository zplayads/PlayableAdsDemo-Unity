using UnityEngine;
using System.Runtime.InteropServices;

namespace PlayableAds.API {
	/**
	 * PlayableAds iOS Plugin Bridge
	 */
	public class PlayableAdsBridge
	{
		[DllImport("__Internal")]
		private static extern void _init(string gameObjName, string appId);

		[DllImport("__Internal")]
		private static extern void _loadAd(string adUnitId);

		[DllImport("__Internal")]
		private static extern void _showAd(string adUnitId);

		[DllImport("__Internal")]
		private static extern bool _isReady(string adUnitId);

		[DllImport("__Internal")]
		private static extern void _autoload(bool autoload);

		[DllImport("__Internal")]
		private static extern bool _isAutoload();

		private static bool isAutoload = true;

		public static void Init(string gameObjName, string appId){
			_init(gameObjName, appId);
		}

		public static void RequestAd(string adUnitId)
		{
			_loadAd(adUnitId);
			_autoload(isAutoload);
		}

		public static void PresentAd(string adUnitId)
		{
			_showAd(adUnitId);
		}

		public static bool IsReady(string adUnitId)
		{
			return _isReady(adUnitId);
		}

		public static void Autoload(bool autoload)
		{
			isAutoload = autoload;
			_autoload(isAutoload);
		}

		public static bool IsAutoload(){
			return _isAutoload();
		}

	}

	public interface IPlayableListener{
		// Reward
		void PlayableAdsDidRewardUser(string msg);

		// ad has been loaded.
		void PlayableAdsDidLoad(string msg);

		// ad load failed
		void DidFailToLoadWithError(string error);

		// user starts playing the ad.
		void PlayableAdsDidStartPlaying(string msg);

		// ad is being fully played.
		void PlayableAdsDidEndPlaying(string msg);

		// the landing page did present on the screen.
		void PlayableAdsDidPresentLandingPage(string msg);

		// the ad did dismiss the screen.
		void PlayableAdsDidDismissScreen(string msg);

		// the ad is clicked
		void PlayableAdsDidClick(string msg);
	}

}
