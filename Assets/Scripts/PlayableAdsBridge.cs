using UnityEngine;
using System.Runtime.InteropServices;

namespace PlayableAds.API {
	/**
	 * PlayableAds iOS Plugin Bridge
	 */
	public class PlayableAdsBridge
	{
		[DllImport("__Internal")]
		private static extern void _loadAd(string gameObjName, string appId, string adUnitId);

		[DllImport("__Internal")]
		private static extern void _showAd();

		[DllImport("__Internal")]
		private static extern bool _isReady();

		[DllImport("__Internal")]
		private static extern void _autoload(bool autoload);

		[DllImport("__Internal")]
		private static extern bool _isAutoload();

		private static bool isAutoload = true;

		public static void RequestAd(string gameObjName, string appId, string adUnitId)
		{
			_loadAd(gameObjName, appId, adUnitId);
			_autoload(isAutoload);
		}

		public static void PresentAd()
		{
			_showAd();
		}

		public static bool IsReady()
		{
			return _isReady();
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

		// Tells the delegate that user starts playing the ad.
		void PlayableAdsDidStartPlaying(string msg);

		// Tells the delegate that the ad is being fully played.
		void PlayableAdsDidEndPlaying(string msg);

		// Tells the delegate that the landing page did present on the screen.
		void PlayableAdsDidPresentLandingPage(string msg);

		// Tells the delegate that the ad did animate off the screen.
		void PlayableAdsDidDismissScreen(string msg);

		// Tells the delegate that the ad is clicked
		void PlayableAdsDidClick(string msg);
	}

}
