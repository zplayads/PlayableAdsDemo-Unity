using UnityEngine;

namespace PlayableAds.API {
	/**
	 * PlayableAds Android Plugin Adapter 
	 */
	public class PlayableAdsAdapter
	{
		private static string objectName;

		public static void Init(string objectName, string appId)
		{
			PlayableAdsAdapter.objectName = objectName;

			using(AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer")) {
				using(AndroidJavaObject jo = jc.GetStatic<AndroidJavaObject>("currentActivity")) {
					AndroidJavaClass sec = new AndroidJavaClass("com.zplay.playable.playableadsplugin.PlayableAdsAdapter");
					sec.CallStatic("InitPA", jo, appId);
				}
			}
		}

		public static void AutoloadAd(bool auto) {
			using(AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer")) {
				using(AndroidJavaObject jo = jc.GetStatic<AndroidJavaObject>("currentActivity")) {
					AndroidJavaClass sec = new AndroidJavaClass("com.zplay.playable.playableadsplugin.PlayableAdsAdapter");
					sec.CallStatic("AutoloadAd", auto);
				}
			}
		}

		public static void CacheCountPerUnitId(int count) {
			using(AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer")) {
				using(AndroidJavaObject jo = jc.GetStatic<AndroidJavaObject>("currentActivity")) {
					AndroidJavaClass sec = new AndroidJavaClass("com.zplay.playable.playableadsplugin.PlayableAdsAdapter");
					sec.CallStatic("CacheCountPerUnitId", count);
				}
			}
		}

		public static void RequestAd(string adUnitId)
		{
			if(objectName == null) {
				throw new MissingReferenceException("havn't set GameObject name to PlayableAdsAdapter");
			}
			using(AndroidJavaClass sec = new AndroidJavaClass("com.zplay.playable.playableadsplugin.PlayableAdsAdapter")) {
				sec.CallStatic("RequestAd", adUnitId, objectName);
			}
		}

		public static void PresentAd(string adUnitId)
		{
			if(objectName == null) {
				throw new MissingReferenceException("havn't set GameObject name to PlayableAdsAdapter");
			}
			using(AndroidJavaClass sec = new AndroidJavaClass("com.zplay.playable.playableadsplugin.PlayableAdsAdapter")) {
				sec.CallStatic("PresentAd", adUnitId, objectName);
			}
		}

		public static bool IsReady(string adUnitId)
		{
			using(AndroidJavaClass sec = new AndroidJavaClass("com.zplay.playable.playableadsplugin.PlayableAdsAdapter")) {
				return sec.CallStatic<bool>("canPresentAd", adUnitId);
			}
		}
	}

	public interface IPlayableAdapterListener {
		
		void OnLoadFinished(string msg);

		void OnLoadFailed(string msg);

		void PlayableAdsIncentive(string msg);

		void PlayableAdsMessage(string msg);
	}
}
