package com.paypals.pagepals;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.IMeetingInviteMenuItem;
import us.zoom.sdk.InMeetingService;
import us.zoom.sdk.JoinMeetingOptions;
import us.zoom.sdk.JoinMeetingParams;
import us.zoom.sdk.MeetingError;
import us.zoom.sdk.MeetingParameter;
import us.zoom.sdk.MeetingService;
import us.zoom.sdk.MeetingServiceListener;
import us.zoom.sdk.MeetingStatus;
import us.zoom.sdk.SimpleZoomUIDelegate;
import us.zoom.sdk.StartMeetingOptions;
import us.zoom.sdk.StartMeetingParamsWithoutLogin;
import us.zoom.sdk.VideoScene;
import us.zoom.sdk.ZoomError;
import us.zoom.sdk.ZoomSDK;
import us.zoom.sdk.ZoomSDKInitParams;
import us.zoom.sdk.ZoomSDKInitializeListener;
import us.zoom.sdk.ZoomUIDelegate;

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
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
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
        meetingService.addListener(this);
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
            Log.d("Failed", "Failed to initialize Zoom SDK");
//            Toast.makeText(
//                    this,
//                    "Failed to initialize Zoom SDK. Error: " + errorCode + ", internalErrorCode=" + internalErrorCode,
//                    Toast.LENGTH_LONG
//            ).show();
        } else {
            Log.d("Success", "Initialize Zoom SDK successfully.");
//            Toast.makeText(this, "Initialize Zoom SDK successfully.", Toast.LENGTH_LONG).show();
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
        InMeetingService inMeetingService = sdk.getInMeetingService();
        if (meetingStatus == MeetingStatus.MEETING_STATUS_FAILED && errorCode == MeetingError.MEETING_ERROR_CLIENT_INCOMPATIBLE) {
            Toast.makeText(this, "Version of ZoomSDK is too low!", Toast.LENGTH_LONG).show();
        } else if (meetingStatus == MeetingStatus.MEETING_STATUS_INMEETING) {
            String userName = inMeetingService.getMyUserInfo().getUserName();
            Log.d("Meeting", userName);
            String text = "You are in the meeting!";
            Toast.makeText(this, text, Toast.LENGTH_LONG).show();
            Log.d("Meeting count", String.valueOf(inMeetingService.getInMeetingUserCount()));
            sdk.getZoomUIService().setZoomUIDelegate(new SimpleZoomUIDelegate() {
                @Override
                public boolean onClickEndButton() {
                    Toast.makeText(MainActivity.this, "End meeting button clicked", Toast.LENGTH_LONG).show();
                    return false;  // set to true to do something else
                }
            });
        } else if (meetingStatus == MeetingStatus.MEETING_STATUS_DISCONNECTING) {
            Toast.makeText(this, "You are disconnecting the meeting!", Toast.LENGTH_LONG).show();
        } else if (meetingStatus == MeetingStatus.MEETING_STATUS_FAILED) {
            Toast.makeText(this, "Failed to connect to the meeting!", Toast.LENGTH_LONG).show();
        } else if (meetingStatus == MeetingStatus.MEETING_STATUS_ENDED) {
            Toast.makeText(this, "Meeting has ended!", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public void onZoomAuthIdentityExpired() {
    }

    @Override
    public void onMeetingParameterNotification(MeetingParameter meetingParameter) {
    }

}

