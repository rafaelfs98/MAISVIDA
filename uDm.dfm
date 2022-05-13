object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 438
  Width = 444
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 56
    Top = 336
  end
  object RESTResponse1: TRESTResponse
    Left = 56
    Top = 384
  end
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Params = <>
    Left = 56
    Top = 280
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 64
    Top = 182
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'cliente.sri'
    Password = '698dc19d489c4e4db73e28a713eab07b'
    Left = 56
    Top = 230
  end
end
