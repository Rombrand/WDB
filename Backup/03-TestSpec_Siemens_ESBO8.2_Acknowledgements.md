# TestSpec Siemens ESBO 8.2 Acknowledgements 

## A. Acknowledgements 
	
	Process data variables which are need for handel acknowledgments:
	
	- NID_ACK_EVC (EVC -> DMI)
		No acknowledge active -> NID_ACK_EVC = 0
		
		1. MVB_GROUP_3_EVC_TO_DMI_ESBO82 [OUT] ->	NID_WINDOW = 3080
													M_WINDOW_SC = 1
													M_VALUE_SC = 0
		2. Send packet: PKT_REQUEST_DIALOG ->		NID_WINDOW = 3080 (WINDOW_RESET_ODOMETRY)
													M_WINDOW_SC = 1
		 
		3. 
		Name					NID_ACK_EVC
		ACK_YES					1
		ACK_YES_DELAY_TYPE		2
		ACK_YES_DISABLE			3
		ACK_YES_NONE			4
	
		Symbole		Bitmap File		Symbol and colour description						Symbole size	Area	Remarks							NID_ACK_EVC
		MO02 		MO_02.bmp		Achnowledgement for Shunting; yellow				32 x 32 		C1		Always with a flashing frame	256
		MO05 		MO_05.bmp		Achnowledgement for Trip; yellow					32 x 32 		C1		Always with a flashing frame	257
		MO08 		MO_08.bmp		Achnowledgement for On Sight; yellow				32 x 32 		C1		Always with a flashing frame	258
		MO10 		MO_10.bmp		Achnowledgement for Staff Responsible; yellow		46 x 46 		C1		Always with a flashing frame	259
		MO15 		MO_15.bmp		Achnowledgement for Reversing; yellow				32 x 32 		C1		Always with a flashing frame	260
		MO17 		MO_17.bmp		Achnowledgement for Unfitted; yellow				32 x 32 		C1		Always with a flashing frame	261
		MO20 		MO_20.bmp		Achnowledgement for National System; yellow			32 x 32 		C1		Always with a flashing frame	262
		MO22 		MO_22.bmp		Achnowledgement for Limited Supervision; yellow		32 x 32 		C1		Always with a flashing frame	263
		
		LE07 		LE_07.bmp		Level 0 aanouncement; yellow						52 x 21 		C1		Always with a flashing frame	264
		LE09 		LE_09.bmp		Level NTC aanouncement; yellow						52 x 21 		C1		Always with a flashing frame	512...767 (NTC not found)
		LE11 		LE_11.bmp		Level 1 aanouncement; yellow						52 x 21 		C1		Always with a flashing frame	265
		LE13 		LE_13.bmp		Level 2 aanouncement; yellow						52 x 21 		C1		Always with a flashing frame	266
		LE15 		LE_15.bmp		Level 3 aanouncement; yellow						52 x 21 		C1		Always with a flashing frame	267
		
		ST01 		ST_01.bmp		Service brake intervention or emergency 			52 x 21 		C9		Possibly with a flashing frame	268
									breake intervention; red with grey
	- T_ACK (EVC -> DMI)
		Value 				Name			Description
		0					T_ACK_NONE		No acknowledge active
		0...4294967295		-				Seconds since 1970-01-01 in UTC
		???
	
	- NID_ACK_DMI (DMI -> EVC)
		NID_ACK_EVC -> ID of displayed Symbole  
	
	- Q_ACK (DMI -> EVC)  
		Value		Name						Description
		0			ACK_FEEDBACK_NONE			No acknowledge feedback
		1			ACK_FEEDBACK_DISPLAYED		Acknowledge request is displayed
		2			ACK_FEEDBACK_ACTIVATED		Acknowledge button was activated
		3...15		-							unused
	
								
	RElated Requirement(s):	#REQ-FFFIS_MMI-010475#DEF#
							#REQ-FFFIS_MMI-010476#DEF#
							#REQ-FFFIS_MMI-010477:01#DEF#
							#REQ-FFFIS_MMI-009659:01#REF#
							#REQ-FFFIS_MMI-010478:01#DEF#
							#REQ-FFFIS_MMI-010479#DEF#
									
	Tests are described in chapter B.

## B Tests for Acknowledgements 
	
	Feature description see chapter A
	
## B.1 Test case of Acknowledgements (Message_PKT_TEXT_03)
 1. Sent a text message which needs a acknowledgements 
	Packet = Message_PKT_TEXT_03
	NID_PACKET = 3
	L_PACKET = 18
	NID_TEXT = 0
	Q_TEXTCLASS = 2 (TEXTCLASS_ACKNOWLEDGE)
	M_ATTRIBUTE = 32906 (ATTRIBUTE_FLASHING_NONE + ATTRIBUTE_BACKGROUND_YELLOW + ATTRIBUTE_TEXT_RED)
	T_UTC = 0
	Q_TEXT_1 = 256 (TEXT_NONE ("Level crossing not protected"))
	Q_TEXT_2 = --
	L_TEXT_1(size-of(X_TEXT_1)+0)
	X_TEXT_1 = (empty)
	L_TEXT_2(size-of(X_TEXT_2)+0)
	X_TEXT_2 = (empty)
 2. Klick on the text message ("Level crossing not protected") => From DMI to EVC mvb-pd-tpdevc -> Q_ACK switch to value 2
																								-> NID_BUT_IND_XX switch 1 seconde to 160 
 3. With MVB_GROUP_3_EVC_TO_DMI_ESBO82 [OUT] -> NIS_ACK_ECV  = x <= 0 but with a change {xt1 != xt2} => the text message disappear
