object dmAPI: TdmAPI
  OldCreateOrder = False
  Height = 406
  Width = 426
  object ActLst_APP: TActionList
    Left = 36
    Top = 20
    object Act_CloseAPP: TAction
      Category = 'SysBtns'
      OnExecute = Act_CloseAPPExecute
    end
    object Act_Minimize: TAction
      Category = 'SysBtns'
      OnExecute = Act_MinimizeExecute
    end
  end
  object ActLst_1: TActionList
    Left = 188
    Top = 236
    object Act_Lyt_Config: TAction
      Caption = 'Email Configuration'
      OnExecute = Act_Lyt_ConfigExecute
    end
    object Act_Lyt_Sending: TAction
      Caption = 'Sending Settings'
      OnExecute = Act_Lyt_SendingExecute
    end
    object Act_SaveData: TAction
      Caption = 'Save'
      OnExecute = Act_SaveDataExecute
    end
    object Act_SendEmail: TAction
      Caption = 'Send'
      OnExecute = Act_SendEmailExecute
    end
    object Act_1: TAction
      Caption = 'Act_1'
    end
  end
end
