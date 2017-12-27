using UnityEngine;
using UnityEngine.UI;
using PlayableAds.API;

public class CameraController : MonoBehaviour, IPlayableListener, IPlayableAdapterListener
{
	#region iOS Test ID
	private readonly string iOSDemoAppId = "iOSDemoApp";
	private readonly string iOSDemoAdUnitId = "iOSDemoAdUnit";
	#endregion

	#region Android Test ID
	private readonly string androidDemoAppId = "androidDemoApp";
	private readonly string androidDemoAdUnitId = "androidDemoAdUnit";
	#endregion

	public Text cbInfo;
	public Button requestBtn;
	public Button presentBtn;

	void Start()
	{
		requestBtn.onClick.AddListener(RequestAd);
		presentBtn.onClick.AddListener(PresentAd);

		#if UNITY_ANDROID
		PlayableAdsAdapter.Init(gameObject.name, androidDemoAppId);
		#endif
	}

	private void RequestAd()
	{
		cbInfo.text = "request ad";

		#if UNITY_IOS
		PlayableAdsBridge.RequestAd(gameObject.name, iOSDemoAppId, iOSDemoAdUnitId);
		#endif

		#if UNITY_ANDROID
		PlayableAdsAdapter.RequestAd(androidDemoAdUnitId);
		#endif
	}

	private void PresentAd()
	{
		cbInfo.text = "present ad";

		#if UNITY_IOS
		if(PlayableAdsBridge.IsReady()) {
		PlayableAdsBridge.PresentAd();
		} else {
		cbInfo.text = "ad not ready.";
		}
		#endif

		#if UNITY_ANDROID
		if(PlayableAdsAdapter.IsReady(androidDemoAdUnitId)) {
		PlayableAdsAdapter.PresentAd(androidDemoAdUnitId);
		} else {
		cbInfo.text = "ad not ready.";
		}
		#endif
	}

	#region PlayableAds iOS Custom Event

	public void PlayableAdsDidRewardUser(string msg)
	{
		cbInfo.text = "Ad has been presented, giving reward.";
	}

	public void PlayableAdsDidLoad(string msg)
	{
		cbInfo.text = "Ad has been loaded, go present it.";
	}

	public void DidFailToLoadWithError(string error)
	{
		cbInfo.text = "Ad failed to load, info: " + error;
	}

	public void PlayableAdFeedBack(string msg)
	{
		Debug.Log("PlayableAd other callback: " + msg);
	}

	#endregion

	#region PlayableAds Android Custom Event

	public void OnLoadFinished(string msg)
	{
		cbInfo.text = "Ad has been loaded, go present it.";
	}

	public void OnLoadFailed(string msg)
	{
		cbInfo.text = "Ad failed to load, info: " + msg;
	}

	public void PlayableAdsIncentive(string msg)
	{
		cbInfo.text = "Ad has been presented, giving reward.";
	}

	public void PlayableAdsMessage(string msg)
	{
		Debug.Log("PlayableAd other callback: " + msg);
	}

	#endregion

}
