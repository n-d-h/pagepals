package com.paypals.pagepals;

import android.util.Log;
import android.widget.Toast;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.JoinMeetingOptions;
import us.zoom.sdk.JoinMeetingParams;
import us.zoom.sdk.MeetingError;
import us.zoom.sdk.MeetingParameter;
import us.zoom.sdk.MeetingService;
import us.zoom.sdk.MeetingServiceListener;
import us.zoom.sdk.MeetingStatus;
import us.zoom.sdk.StartMeetingOptions;
import us.zoom.sdk.StartMeetingParamsWithoutLogin;
import us.zoom.sdk.ZoomError;
import us.zoom.sdk.ZoomSDK;
import us.zoom.sdk.ZoomSDKInitParams;
import us.zoom.sdk.ZoomSDKInitializeListener;

public class MainActivity extends FlutterActivity implements MeetingServiceListener, ZoomSDKInitializeListener {
    private static String JWT_TOKEN = "ZOOM-JWT-TOKEN";
    private static String ZOOM_ACCESS_TOKEN = "ZOOM-ZAK-TOKEN";
    private static final String WEB_DOMAIN = "zoom.us";
    private static String MEETINGID = null;
    private static String PASSCODE = null;
    private static String DISPLAY_NAME = "Zoom Demo App";
    private static final String CHANNEL = "zoom_sdk_channel";
    private ZoomSDK sdk;

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if ("initializeZoomSDK".equals(call.method)) {
                        JWT_TOKEN = call.argument("jwtToken");
                        initialiseSDK(JWT_TOKEN);
                    } else if ("joinMeeting".equals(call.method)) {
                        MEETINGID = call.argument("meetingID");
                        PASSCODE = call.argument("meetingPasscode");
                        DISPLAY_NAME = call.argument("displayName");
                        joinMeeting(MEETINGID, PASSCODE, DISPLAY_NAME);
                    } else if ("startMeeting".equals(call.method)) {
                        MEETINGID = call.argument("meetingID");
                        DISPLAY_NAME = call.argument("displayName");
                        ZOOM_ACCESS_TOKEN = call.argument("zoomAccessToken");
                        startMeeting(MEETINGID, DISPLAY_NAME, ZOOM_ACCESS_TOKEN);
                    } else {
                        result.notImplemented();
                    }
                });
    }


    private void initialiseSDK(String jwtToken) {
        sdk = ZoomSDK.getInstance();
        ZoomSDKInitParams initParams = new ZoomSDKInitParams();
        initParams.jwtToken = jwtToken;
        initParams.enableLog = true;
        initParams.domain = WEB_DOMAIN;
        sdk.initialize(this, this, initParams);
    }

    private void joinMeeting(String meetingID, String passcode, String displayName) {
        MeetingService meetingService = sdk.getMeetingService();
        JoinMeetingOptions opts = new JoinMeetingOptions();
        opts.no_invite = true;
        JoinMeetingParams params = new JoinMeetingParams();
        params.displayName = displayName;
        params.meetingNo = meetingID;
        params.password = passcode;
        meetingService.joinMeetingWithParams(this, params, opts);
    }

    private void startMeeting(String meetingID, String displayName, String zoomAccessToken) {
        MeetingService meetingService = sdk.getMeetingService();
        StartMeetingOptions opts = new StartMeetingOptions();
        opts.no_invite = true;
        StartMeetingParamsWithoutLogin params = new StartMeetingParamsWithoutLogin();
        params.zoomAccessToken = zoomAccessToken;
        params.meetingNo = meetingID;
        params.displayName = displayName;
        meetingService.startMeetingWithParams(this, params, opts);
    }

    @Override
    public void onZoomSDKInitializeResult(int errorCode, int internalErrorCode) {
        if (errorCode != ZoomError.ZOOM_ERROR_SUCCESS) {
            Log.d("Failed", "Failed to initialize Zoom SDK.");
        } else {
            Log.d("Success", "Initialize Zoom SDK successfully.");
        }
    }

    private void registerMeetingServiceListener() {
        MeetingService meetingService = sdk.getMeetingService();
        meetingService.addListener(this);
    }

    @Override
    protected void onDestroy() {
        ZoomSDK zoomSDK = ZoomSDK.getInstance();
        if (zoomSDK.isInitialized()) {
            MeetingService meetingService = zoomSDK.getMeetingService();
            meetingService.removeListener(this);
        }
        super.onDestroy();
    }

    @Override
    public void onMeetingStatusChanged(MeetingStatus meetingStatus, int errorCode, int internalErrorCode) {
        if (meetingStatus == MeetingStatus.MEETING_STATUS_FAILED && errorCode == MeetingError.MEETING_ERROR_CLIENT_INCOMPATIBLE) {
            Toast.makeText(this, "Version of ZoomSDK is too low!", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public void onZoomAuthIdentityExpired() {
    }

    @Override
    public void onMeetingParameterNotification(MeetingParameter meetingParameter) {
    }
}

