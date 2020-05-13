//
//  ms2log.h
//  EverTalk
//
//  Created by dgw on 16/6/25.
//  Copyright © 2016年 dnake. All rights reserved.
//

#ifndef ms2log_h
#define ms2log_h

void ms2_dbg_log(int log_level,const char* module,const char* fmt,...);
void ms2_set_log_level(int log_level);

#define 	LOG_LEVEL_FATAL			0
#define 	LOG_LEVEL_ERROR			1
#define 	LOG_LEVEL_WARN			2
#define 	LOG_LEVEL_INFO			3
#define 	LOG_LEVEL_DEBUG			4


/************************************************************************/
/* define                                                               */
/************************************************************************/
/*
 * log module
 */
/*
 * <<<<you might need to add your module here!!>>>>
 */

#define  LOG 				"ani-def"
#define  LOG_MOD_SIP		"ani-sip"        /* sip */
#define  LOG_MOD_MED		"ani-med"        /* media */
#define  LOG_MOD_MUL		"ani-mul"        /* multicast */
#define  LOG_MOD_GUI		"ani-gui"        /* gui */
#define  LOG_MOD_KPL		"ani-kpl"        /* keeplive */
#define  LOG_MOD_MSG		"ani-msg"        /* communicaition msg*/


/************************************************************************/
/* log for communicaition msg                                           */
/************************************************************************/
#define MSG_LOGD(...) ms2_dbg_log(LOG_LEVEL_DEBUG,  LOG_MOD_MSG,  __VA_ARGS__)
#define MSG_LOGI(...) ms2_dbg_log(LOG_LEVEL_INFO,   LOG_MOD_MSG,  __VA_ARGS__)
#define MSG_LOGW(...) ms2_dbg_log(LOG_LEVEL_WARN,   LOG_MOD_MSG,  __VA_ARGS__)
#define MSG_LOGE(...) ms2_dbg_log(LOG_LEVEL_ERROR,  LOG_MOD_MSG,  __VA_ARGS__)
#define MSG_LOGF(...) ms2_dbg_log(LOG_LEVEL_FATAL,  LOG_MOD_MSG,  __VA_ARGS__)


/************************************************************************/
/* log for keeplive                                                     */
/************************************************************************/
#define KPL_LOGD(...) ms2_dbg_log(LOG_LEVEL_DEBUG,  LOG_MOD_KPL,  __VA_ARGS__)
#define KPL_LOGI(...) ms2_dbg_log(LOG_LEVEL_INFO,   LOG_MOD_KPL,  __VA_ARGS__)
#define KPL_LOGW(...) ms2_dbg_log(LOG_LEVEL_WARN,   LOG_MOD_KPL,  __VA_ARGS__)
#define KPL_LOGE(...) ms2_dbg_log(LOG_LEVEL_ERROR,  LOG_MOD_KPL,  __VA_ARGS__)
#define KPL_LOGF(...) ms2_dbg_log(LOG_LEVEL_FATAL,  LOG_MOD_KPL,  __VA_ARGS__)

/************************************************************************/
/* log for sip                                                          */
/************************************************************************/
#define SIP_LOGD(...) ms2_dbg_log(LOG_LEVEL_DEBUG,  LOG_MOD_SIP,  __VA_ARGS__)
#define SIP_LOGI(...) ms2_dbg_log(LOG_LEVEL_INFO,   LOG_MOD_SIP,  __VA_ARGS__)
#define SIP_LOGW(...) ms2_dbg_log(LOG_LEVEL_WARN,   LOG_MOD_SIP,  __VA_ARGS__)
#define SIP_LOGE(...) ms2_dbg_log(LOG_LEVEL_ERROR,  LOG_MOD_SIP,  __VA_ARGS__)
#define SIP_LOGF(...) ms2_dbg_log(LOG_LEVEL_FATAL,  LOG_MOD_SIP,  __VA_ARGS__)

/************************************************************************/
/* log for media                                                        */
/************************************************************************/
#define MED_LOGD(...) ms2_dbg_log(LOG_LEVEL_DEBUG,  LOG_MOD_MED,  __VA_ARGS__)
#define MED_LOGI(...) ms2_dbg_log(LOG_LEVEL_INFO,   LOG_MOD_MED,  __VA_ARGS__)
#define MED_LOGW(...) ms2_dbg_log(LOG_LEVEL_WARN,   LOG_MOD_MED,  __VA_ARGS__)
#define MED_LOGE(...) ms2_dbg_log(LOG_LEVEL_ERROR,  LOG_MOD_MED,  __VA_ARGS__)
#define MED_LOGF(...) ms2_dbg_log(LOG_LEVEL_FATAL,  LOG_MOD_MED,  __VA_ARGS__)

/************************************************************************/
/* log for multicast                                         			*/
/************************************************************************/
#define MUL_LOGD(...) ms2_dbg_log(LOG_LEVEL_DEBUG,  LOG_MOD_MUL,  __VA_ARGS__)
#define MUL_LOGI(...) ms2_dbg_log(LOG_LEVEL_INFO,   LOG_MOD_MUL,  __VA_ARGS__)
#define MUL_LOGW(...) ms2_dbg_log(LOG_LEVEL_WARN,   LOG_MOD_MUL,  __VA_ARGS__)
#define MUL_LOGE(...) ms2_dbg_log(LOG_LEVEL_ERROR,  LOG_MOD_MUL,  __VA_ARGS__)
#define MUL_LOGF(...) ms2_dbg_log(LOG_LEVEL_FATAL,  LOG_MOD_MUL,  __VA_ARGS__)

/************************************************************************/
/* log for GUI2JNI                                         			*/
/************************************************************************/
//#define GUI_LOGD(...) ms2_dbg_log(LOG_LEVEL_DEBUG,  LOG_MOD_GUI,  __VA_ARGS__)
//#define GUI_LOGI(...) ms2_dbg_log(LOG_LEVEL_INFO,   LOG_MOD_GUI,  __VA_ARGS__)
//#define GUI_LOGW(...) ms2_dbg_log(LOG_LEVEL_WARN,   LOG_MOD_GUI,  __VA_ARGS__)
//#define GUI_LOGE(...) ms2_dbg_log(LOG_LEVEL_ERROR,  LOG_MOD_GUI,  __VA_ARGS__)
//#define GUI_LOGF(...) ms2_dbg_log(LOG_LEVEL_FATAL,  LOG_MOD_GUI,  __VA_ARGS__)



#endif /* ms2log_h */
