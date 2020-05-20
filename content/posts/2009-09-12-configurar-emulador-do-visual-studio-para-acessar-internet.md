---
id: 44
title: Configurar Emulador do Visual Studio para Acessar Internet
date: 2009-09-12
author: carloscds
layout: post
guid: /post/2009/09/12/Configurar-Emulador-do-Visual-Studio-para-Acessar-Internet.aspx
permalink: /2009/09/configurar-emulador-do-visual-studio-para-acessar-internet/
aktt_notify_twitter:
  - 'yes'
categories:
  - Mobilidade
  - Visual Studio
tags:
  - mobilidade; msdn
---
<div id="msgcns!FD3250D50A81A829!1320">
  <div>
    <div>
      Pessoal,
    </div>
    
    <div>
    </div>
    
    <div>
      Resolvi publicar este post devido ao grande número de pessoas que solicitam este tipo de informação no fórum de mobilidade do MSDN. O objetivo é apresentar passo a passo como configurar o emulador do Visual Studio para acessar a rede e tambem a internet.
    </div>
    
    <div>
    </div>
    
    <div>
      Então vamos lá:
    </div>
    
    <div>
    </div>
    
    <div>
      1. Abra o emulador do Visual Studio (Tools/Connect to Device) e escolha o emulador de sua preferência (WM 5, 6 ou 6.5). Dentro do emulador, clique em File/Configure:
    </div>
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mkqruKYeCWv2hUnSmccn1kwyFEzXMupUySXqegMoIGxKuZSJtzWTkBqPi_RSvx3s-gn8r3AA6a9iWiaXqnWQZIxBO4efmlpQyWd1HkgtRerfCGDmmVFPb_nF0VM8fo7gjmbPb3EdJ2J0W6-RMIyKbNQ/Imagem1.png" href="https://mqqj0q.blu.livefilestore.com/y1mkqruKYeCWv2hUnSmccn1kwyFEzXMupUySXqegMoIGxKuZSJtzWTkBqPi_RSvx3s-gn8r3AA6a9iWiaXqnWQZIxBO4efmlpQyWd1HkgtRerfCGDmmVFPb_nF0VM8fo7gjmbPb3EdJ2J0W6-RMIyKbNQ/Imagem1.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mkqruKYeCWv2hUnSmccn1kwyFEzXMupUySXqegMoIGxKuZSJtzWTkBqPi_RSvx3s-gn8r3AA6a9iWiaXqnWQZIxBO4efmlpQyWd1HkgtRerfCGDmmVFPb_nF0VM8fo7gjmbPb3EdJ2J0W6-RMIyKbNQ/Imagem1.png" alt="" /></a>
  </div>
  
  <div>
    2. Escolha NetWork e clique para habilitar a placa de rede (connected network inidica a placa que  está ativa no nomendo no seu computador, caso tenha mais que uma):
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mD43pJeOrRSkx9FrpXIOFUjMzqypSMQss-geFp7ImpdvE9Yb0yYI_e-klvalol3H1CiGA-eYRh6VLeG5z0mLaCgHbFjfqx2B2YEaHfDTEIz8gERU5Q5d1drMg4VmpZP_nS14PlBhR9CyMJ2KTVrLmIQ/Imagem2.png" href="https://mqqj0q.blu.livefilestore.com/y1mD43pJeOrRSkx9FrpXIOFUjMzqypSMQss-geFp7ImpdvE9Yb0yYI_e-klvalol3H1CiGA-eYRh6VLeG5z0mLaCgHbFjfqx2B2YEaHfDTEIz8gERU5Q5d1drMg4VmpZP_nS14PlBhR9CyMJ2KTVrLmIQ/Imagem2.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mD43pJeOrRSkx9FrpXIOFUjMzqypSMQss-geFp7ImpdvE9Yb0yYI_e-klvalol3H1CiGA-eYRh6VLeG5z0mLaCgHbFjfqx2B2YEaHfDTEIz8gERU5Q5d1drMg4VmpZP_nS14PlBhR9CyMJ2KTVrLmIQ/Imagem2.png" alt="" /></a>
  </div>
  
  <div>
    3. Para compartilhar a placa de rede, você precsa do Virtual Machine Network Manager, que faz parte do Virtual PC 2007. &#8220;
  </div>
  
  <div>
    Caso você não tenha, baixe <a href="http://www.microsoft.com/downloads/details.aspx?FamilyId=04D26402-3199-48A3-AFA2-2DC0B40A73B6&displaylang=en" target="_blank">aqui</a>. Depois de baixado, repita o passo 2, habilitando a placa de rede.
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mjkdOwVycXIIIt9T9NaeGVFMtvBorA1rnIzQdF7fJI3yTHS90diPJYUJt8Blfdv-hLifgEKa4Yj_k7SKoH1Zik0-5ye0p2FALzewrClI3Q5Cokqrvv_wzmCLUbfrcT_0kUOwJhLXfvkpRlO7r8rs_8w/Imagem3.png" href="https://mqqj0q.blu.livefilestore.com/y1mjkdOwVycXIIIt9T9NaeGVFMtvBorA1rnIzQdF7fJI3yTHS90diPJYUJt8Blfdv-hLifgEKa4Yj_k7SKoH1Zik0-5ye0p2FALzewrClI3Q5Cokqrvv_wzmCLUbfrcT_0kUOwJhLXfvkpRlO7r8rs_8w/Imagem3.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mjkdOwVycXIIIt9T9NaeGVFMtvBorA1rnIzQdF7fJI3yTHS90diPJYUJt8Blfdv-hLifgEKa4Yj_k7SKoH1Zik0-5ye0p2FALzewrClI3Q5Cokqrvv_wzmCLUbfrcT_0kUOwJhLXfvkpRlO7r8rs_8w/Imagem3.png" alt="" /></a>
  </div>
  
  <div>
    4. Após isto, seu emulador já estará conectado, com um IP da sua rede local, caso você tenha um servidor DHCP:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mWWkpV9Ni_-aQAG-DGS9nVItq1TktXSxCrhpK0AHLpcr38Gg9K51TFFSeuvZtDq6QJBScuG2BF_N-_D42mIXrrHnIa2CppX89hXy1Pa8d2czrO-QGV-j2hySzJ1Kgstle8uCPOvOm8g38ZmqbUqTAIQ/Imagem4.png" href="https://mqqj0q.blu.livefilestore.com/y1mWWkpV9Ni_-aQAG-DGS9nVItq1TktXSxCrhpK0AHLpcr38Gg9K51TFFSeuvZtDq6QJBScuG2BF_N-_D42mIXrrHnIa2CppX89hXy1Pa8d2czrO-QGV-j2hySzJ1Kgstle8uCPOvOm8g38ZmqbUqTAIQ/Imagem4.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mWWkpV9Ni_-aQAG-DGS9nVItq1TktXSxCrhpK0AHLpcr38Gg9K51TFFSeuvZtDq6QJBScuG2BF_N-_D42mIXrrHnIa2CppX89hXy1Pa8d2czrO-QGV-j2hySzJ1Kgstle8uCPOvOm8g38ZmqbUqTAIQ/Imagem4.png" alt="" /></a>
  </div>
  
  <div>
    5. Caso você queira fixar um IP no emulador. Dentro do emulador vá em Stat/Settings e clique em Connections:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mh_uqnSjEdgZlDg8Jz4D7nSxRrf5rMJsovUb3YJZsL2FD4swL5y_0nhi-cP4ESj5RBDB6jRKulAMyd76KXkfUahn2t_iJdFnXd3RX0-9leQAqV1qRxzigqqDuJh1NDWt54LMPA2wlt6IdL6kPB4ohEA/Imagem5.png" href="https://mqqj0q.blu.livefilestore.com/y1mh_uqnSjEdgZlDg8Jz4D7nSxRrf5rMJsovUb3YJZsL2FD4swL5y_0nhi-cP4ESj5RBDB6jRKulAMyd76KXkfUahn2t_iJdFnXd3RX0-9leQAqV1qRxzigqqDuJh1NDWt54LMPA2wlt6IdL6kPB4ohEA/Imagem5.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mh_uqnSjEdgZlDg8Jz4D7nSxRrf5rMJsovUb3YJZsL2FD4swL5y_0nhi-cP4ESj5RBDB6jRKulAMyd76KXkfUahn2t_iJdFnXd3RX0-9leQAqV1qRxzigqqDuJh1NDWt54LMPA2wlt6IdL6kPB4ohEA/Imagem5.png" alt="" /></a>
  </div>
  
  <div>
    6. Clique novamente em Connections:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mAlbbyZwgtVMql2yQsUJnJv073HpJz2XazGgXL6mWdyCmrmNd_x_ndDTl9crkodtgfIZSDf_2GBY1kD60_CNh89yB97MwGtc5CflEOp9Y_YLCxO44idLs9LX3WOtgTHoKAv1wrLfI173mQJ-fK2qt3g/Imagem6.png" href="https://mqqj0q.blu.livefilestore.com/y1mAlbbyZwgtVMql2yQsUJnJv073HpJz2XazGgXL6mWdyCmrmNd_x_ndDTl9crkodtgfIZSDf_2GBY1kD60_CNh89yB97MwGtc5CflEOp9Y_YLCxO44idLs9LX3WOtgTHoKAv1wrLfI173mQJ-fK2qt3g/Imagem6.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mAlbbyZwgtVMql2yQsUJnJv073HpJz2XazGgXL6mWdyCmrmNd_x_ndDTl9crkodtgfIZSDf_2GBY1kD60_CNh89yB97MwGtc5CflEOp9Y_YLCxO44idLs9LX3WOtgTHoKAv1wrLfI173mQJ-fK2qt3g/Imagem6.png" alt="" /></a>
  </div>
  
  <div>
    7. Você verá as configurações de rede, onde My ISP, em um dispositivo real, se refere a conexão com o provedor de internet (GPRS, EDGE, etc) e My NetWork se refere a sua rede. Nesta tela, clique em Advanced:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mEUMsB_u2Urv-09zYUde5FPZX7A3g9dAWEdeA8ZWbzlukWQgTBnG69b1CZaortr4ls9SWJtJAbfc3Grotm1zvFBnzEzGyiCCXfawcpYgasWRzUcBlDk9H9CoUg0WtgpdD5Q3hL0Ltp6jCRwwHhsURyg/Imagem7.png" href="https://mqqj0q.blu.livefilestore.com/y1mEUMsB_u2Urv-09zYUde5FPZX7A3g9dAWEdeA8ZWbzlukWQgTBnG69b1CZaortr4ls9SWJtJAbfc3Grotm1zvFBnzEzGyiCCXfawcpYgasWRzUcBlDk9H9CoUg0WtgpdD5Q3hL0Ltp6jCRwwHhsURyg/Imagem7.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mEUMsB_u2Urv-09zYUde5FPZX7A3g9dAWEdeA8ZWbzlukWQgTBnG69b1CZaortr4ls9SWJtJAbfc3Grotm1zvFBnzEzGyiCCXfawcpYgasWRzUcBlDk9H9CoUg0WtgpdD5Q3hL0Ltp6jCRwwHhsURyg/Imagem7.png" alt="" /></a>
  </div>
  
  <div>
    8. Clique em Select Networks, para modificar as conexões:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mNUB2vPW36mysocVIX4ZnwE1K0wU_HVSVzPtI-hOWi2WSod5XmOoIyMyS_WKe-YAtRiiFEON03cJKM43qWdqSTH1lbXNyURdYc8EuhpYr45qR3hZ1_HbK4N-JcrLNXhQjjX3_bweQU9rUp99y8iT1Fg/Imagem8.png" href="https://mqqj0q.blu.livefilestore.com/y1mNUB2vPW36mysocVIX4ZnwE1K0wU_HVSVzPtI-hOWi2WSod5XmOoIyMyS_WKe-YAtRiiFEON03cJKM43qWdqSTH1lbXNyURdYc8EuhpYr45qR3hZ1_HbK4N-JcrLNXhQjjX3_bweQU9rUp99y8iT1Fg/Imagem8.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mNUB2vPW36mysocVIX4ZnwE1K0wU_HVSVzPtI-hOWi2WSod5XmOoIyMyS_WKe-YAtRiiFEON03cJKM43qWdqSTH1lbXNyURdYc8EuhpYr45qR3hZ1_HbK4N-JcrLNXhQjjX3_bweQU9rUp99y8iT1Fg/Imagem8.png" alt="" /></a>
  </div>
  
  <div>
    9. Mude as primeira rede para My Network:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mNEdYZBuDzPvf5cssKRJG5YbO941Mrqrohp6mmSd41UBmg6HhNMfHHVccGcZK395OJgh2KLB_R3QBaLPrIQd97z_KLgAX5KYn0bSU31SPQr6YXbvH5uNvFd7zKJ2UcKZ-_dT0lpZRLP3McdvWYyo16A/Imagem9.png" href="https://mqqj0q.blu.livefilestore.com/y1mNEdYZBuDzPvf5cssKRJG5YbO941Mrqrohp6mmSd41UBmg6HhNMfHHVccGcZK395OJgh2KLB_R3QBaLPrIQd97z_KLgAX5KYn0bSU31SPQr6YXbvH5uNvFd7zKJ2UcKZ-_dT0lpZRLP3McdvWYyo16A/Imagem9.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mNEdYZBuDzPvf5cssKRJG5YbO941Mrqrohp6mmSd41UBmg6HhNMfHHVccGcZK395OJgh2KLB_R3QBaLPrIQd97z_KLgAX5KYn0bSU31SPQr6YXbvH5uNvFd7zKJ2UcKZ-_dT0lpZRLP3McdvWYyo16A/Imagem9.png" alt="" /></a>
  </div>
  
  <div>
    10. Caso queira configurar o IP manualmente no emulador, vá em Start/Settings/Connections e clique em Network  Cards:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1m6dCZKhjDKgJK50TPpDUucundy3LbCSTVR6TAqqXFSs4BjXT4SmsP6DeoT9PH4wLtrpp2ESGWmM8iyQNn8N2a8wOaRrO3u3nezAwFbSqYzEiLB9DYeheu32CPmqzTuJ4pTwXV8i4O0OCr6Ssux80BSg/Imagem10.png" href="https://mqqj0q.blu.livefilestore.com/y1m6dCZKhjDKgJK50TPpDUucundy3LbCSTVR6TAqqXFSs4BjXT4SmsP6DeoT9PH4wLtrpp2ESGWmM8iyQNn8N2a8wOaRrO3u3nezAwFbSqYzEiLB9DYeheu32CPmqzTuJ4pTwXV8i4O0OCr6Ssux80BSg/Imagem10.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1m6dCZKhjDKgJK50TPpDUucundy3LbCSTVR6TAqqXFSs4BjXT4SmsP6DeoT9PH4wLtrpp2ESGWmM8iyQNn8N2a8wOaRrO3u3nezAwFbSqYzEiLB9DYeheu32CPmqzTuJ4pTwXV8i4O0OCr6Ssux80BSg/Imagem10.png" alt="" /></a>
  </div>
  
  <div>
    11. Escolha o adaptador NE2000:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1mI6X5kCooYSWAXtUvWXJQcFigbVbllxBw_Q77TZ3mYqjQO9WbZrtjkzz_6a7vr-gCYaz0g4tkUKnDRBQ4SEhe_jshQ-piCTuCcGkwoYkgsbyT0hHOrS8AUEcC0mAKKYpl9sc8-MRlsY5O3HtPeZhysg/Imagem11.png" href="https://mqqj0q.blu.livefilestore.com/y1mI6X5kCooYSWAXtUvWXJQcFigbVbllxBw_Q77TZ3mYqjQO9WbZrtjkzz_6a7vr-gCYaz0g4tkUKnDRBQ4SEhe_jshQ-piCTuCcGkwoYkgsbyT0hHOrS8AUEcC0mAKKYpl9sc8-MRlsY5O3HtPeZhysg/Imagem11.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1mI6X5kCooYSWAXtUvWXJQcFigbVbllxBw_Q77TZ3mYqjQO9WbZrtjkzz_6a7vr-gCYaz0g4tkUKnDRBQ4SEhe_jshQ-piCTuCcGkwoYkgsbyT0hHOrS8AUEcC0mAKKYpl9sc8-MRlsY5O3HtPeZhysg/Imagem11.png" alt="" /></a>
  </div>
  
  <div>
    12. Mude o IP para Manual e especifique as configurações. Clicando em Name Servers, vocês poderão configurar o DNS:
  </div>
  
  <div>
    <a rel="WLPP;url=https://mqqj0q.blu.livefilestore.com/y1myATBbxRdsWHvQlOTZEONMspXj9KilZxu6LwayeLeIS-BtSqa9C3c1oeI7WXcPmQdPFCIv0ujeibX8srpdw3eXsuIQcR5EtytK_dtRscrwjl0AK9ycNPpAs_yEAZ27-WFrLelSvjt8irVUE8DIoqv2g/Imagem12.png" href="https://mqqj0q.blu.livefilestore.com/y1myATBbxRdsWHvQlOTZEONMspXj9KilZxu6LwayeLeIS-BtSqa9C3c1oeI7WXcPmQdPFCIv0ujeibX8srpdw3eXsuIQcR5EtytK_dtRscrwjl0AK9ycNPpAs_yEAZ27-WFrLelSvjt8irVUE8DIoqv2g/Imagem12.png" target="_blank"><img src="https://mqqj0q.blu.livefilestore.com/y1myATBbxRdsWHvQlOTZEONMspXj9KilZxu6LwayeLeIS-BtSqa9C3c1oeI7WXcPmQdPFCIv0ujeibX8srpdw3eXsuIQcR5EtytK_dtRscrwjl0AK9ycNPpAs_yEAZ27-WFrLelSvjt8irVUE8DIoqv2g/Imagem12.png" alt="" /></a>
  </div>
  
  <div>
    É isto pessoal, espero que seja útil para todos.
  </div>
  
  <div>
    []s,
  </div>
  
  <div>
    Carlos dos Santos.
  </div>
</div>

<div>
  15:57 | <a id="blogThis0" title="Blogue sobre esta entrada no seu espaço">Incluir no blog</a> | <a id="blogCategory0" title="Mostre todas as entradas desta categoria" href="http://cdssoftware.spaces.live.com/?_c11_BlogPart_BlogPart=blogview&_c=BlogPart&partqs=cat%3dTecnologia">Tecnol</a>
</div>