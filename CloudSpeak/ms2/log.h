//
//  log.h
//  EverTalk
//
//  Created by DnakeWCZ on 16/5/12.
//  Copyright © 2016年 dnake. All rights reserved.
//

#ifndef log_h
#define log_h
/************************************************************************/
/* define                                                               */
/************************************************************************/

//定义是否将NSlog保存到SD卡中
#define REDIRECT_NSLOG_TO_DOC                   1

#define  LOG_MOD_UI         @"GUI-UI   "        /* GUI */


/************************************************************************/
/* log for GUI														    */
/************************************************************************/
//#define GUI_LOGE(frmt, ...) LOG_MAYBE(NO,               LOG_LEVEL_DEF,DDLogFlagError,  0,LOG_MOD_UI,__PRETTY_FUNCTION__,frmt, ##__VA_ARGS__)
//#define GUI_LOGW(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED,LOG_LEVEL_DEF,DDLogFlagWarning,0,LOG_MOD_UI,__PRETTY_FUNCTION__,frmt, ##__VA_ARGS__)
//#define GUI_LOGI(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED,LOG_LEVEL_DEF,DDLogFlagInfo,   0,LOG_MOD_UI,__PRETTY_FUNCTION__,frmt, ##__VA_ARGS__)
//#define GUI_LOGD(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED,LOG_LEVEL_DEF,DDLogFlagDebug,  0,LOG_MOD_UI,__PRETTY_FUNCTION__,frmt, ##__VA_ARGS__)
//#define GUI_LOGV(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED,LOG_LEVEL_DEF,DDLogFlagVerbose,0,LOG_MOD_UI,__PRETTY_FUNCTION__,frmt, ##__VA_ARGS__)

#define GUI_LOGE    NSLog
#define GUI_LOGW    NSLog
#define GUI_LOGI    NSLog
#define GUI_LOGD    NSLog
#define GUI_LOGV    NSLog



/************************************************************************/
/* log for GUI                                                          */
/************************************************************************/

#define LOG_LEVEL LogLevelVerbose   //定义打印等级

#define    LogFlagError      (1 << 0)
#define    LogFlagWarning    (1 << 1)
#define    LogFlagInfo       (1 << 2)
#define    LogFlagDebug      (1 << 3)
#define    LogFlagVerbose    (1 << 4)


#define    LogLevelOff       0
#define    LogLevelError     (LogFlagError)
#define    LogLevelWarning   (LogLevelError   | LogFlagWarning)
#define    LogLevelInfo      (LogLevelWarning | LogFlagInfo)
#define    LogLevelDebug     (LogLevelInfo    | LogFlagDebug)
#define    LogLevelVerbose   (LogLevelDebug   | LogFlagVerbose)

#if !((LOG_LEVEL) & (LogFlagError))
#undef  GUI_LOGE
#define GUI_LOGE(frmt,...)
#endif
#if !((LOG_LEVEL) & (LogFlagWarning))
#undef  GUI_LOGW
#define GUI_LOGW(...)
#endif
#if !((LOG_LEVEL) & (LogFlagInfo))
#undef  GUI_LOGI
#define GUI_LOGI(frmt,...)
#endif
#if !((LOG_LEVEL) & (LogFlagDebug))
#undef  GUI_LOGD
#define GUI_LOGD(frmt,...)
#endif
#if !((LOG_LEVEL) & (LogFlagVerbose))
#undef  GUI_LOGV
#define GUI_LOGV(frmt,...)
#endif

#endif /* log_h */
