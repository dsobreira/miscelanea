#Include "Protheus.ch"

/*/{Protheus.doc} aItemx
(long_description)
@author Daniel_Sobreira
@since 07/12/2016
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
class aItemx
	data Filial
	data citem
	data cProduto
	data cxTabpr
	data nQuant
	data nPrunit
	data nValor
	data cxPrcve
	data cxPrfat
	data cxFilfa
	data cNropor
	data cRevisa
	data cHistor
	data nxDesco
	data nxColun
	data nxAltur
	data nxForma
	data nxPagin
	data nxprctb
	data deleta
	
	method new(aItemx) constructor 
endclass

/*/{Protheus.doc} AD1Oportun
(long_description)
@author Daniel_Sobreira
@since 08/11/2016
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
class AD1Oportun 
	data Filial
	data cNrOpor
	data cRevisa
	data cDescri
	data cUser
	data cVend
	data cNomeVend
	data dtini
	data cProven
	data cStage
	data cPrior
	data cStatus
	data cProspe
	data cLojPro
	data cCodCli
	data cLojCli
	data TextoM
	data aItens
//	data cData
//	data cHora
//	data nMoeda

	method new(cNrOpor) constructor
	method setProperties(cNrOpor,cRevisa)
	method save()					//finalizar

endclass

/*/{Protheus.doc} new
Metodo construtor
@author Daniel_Sobreira
@since 07/12/2016 
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
method new(axItens) class aItemx

	Default axItens:={"","","","","",0,"","",0,0,0,0,0,0,0,0,"",0,"false"}
	
	::Filial	:= xFilial("ADJ")
	::cHistor	:= axItens[01]
	::citem		:= axItens[02]
	::cNrOpor	:= axItens[03]
	::cProduto	:= axItens[04]
	::cRevisa	:= axItens[05]
	::cxPrcve	:= axItens[06]
	::cxFilfa	:= axItens[17]
	::cxPrfat	:= axItens[07]
	::cxTabpr	:= axItens[08]
	::nPrunit	:= axItens[09]
	::nQuant	:= axItens[10]
	::nValor	:= axItens[11]
	::nxDesco	:= axItens[12]
	::nxColun	:= axItens[13]
	::nxAltur	:= axItens[14]
	::nxForma	:= axItens[15]
	::nxPagin	:= axItens[16]
	::nxprctb	:= axItens[18]
	::deleta	:= axItens[19]

return self

/*/{Protheus.doc} new
Metodo construtor
@author Daniel_Sobreira
@since 08/11/2016 
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
method new(cNrOpor,cRevisa,lIsList) class AD1Oportun
	local aVend	 := {}
	Local cCod	 := ""
	Local cLoja	 := ""
	Local cRevisa:= ""
	Local cDescri:= ""
	Local cProven:= ""
	Local cStage := ""
	Local cPrior := ""
	Local cStatus:= ""
	Local cTextoM:= ""
	Local cVende := ""
	Local cNomeVe:= ""
	Local cProspe:= ""
	Local cLojPro:= ""
	Local cDtini := ""
	Local nMoeda := 1
	Local nCont	 := 0
	Local aItens := {}						// {"","","","","",0,"","",0,0,0,0,0,0,0,0,"",0,"false"}

	default cNrOpor	:= GetNrOpor()			//GetCodSU5(GetSxeNum("AD1","AD1_NROPOR"))
	default lIsList	:= .F.

	cRevisa		:= GetRevisa(cNrOpor)
	::cRevisa	:= cRevisa

	aVend		:= GetVended(__cUserId)		//CUSERNAME -->> O Codigo do Administrador _cUesrID="000000"

	DbSelectArea("AD1")
	AD1->(dbsetorder(1))
	ADJ->(dbsetorder(1))

	::filial:= xFilial("AD1")

	if AD1->(dbseek(xFilial("AD1") + cNrOpor ))	//+ cRevisa ))
		cDescri	:= AD1->AD1_DESCRI
		cProven := AD1->AD1_PROVEN
		cStage	:= AD1->AD1_STAGE
		nMoeda	:= AD1->AD1_MOEDA
		cPrior	:= AD1->AD1_PRIOR
		cStatus	:= AD1->AD1_STATUS
		cCod	:= AD1->AD1_CODCLI
		cLoja	:= AD1->AD1_LOJCLI
		cVende	:= AD1->AD1_VEND
		cDtIni	:= AD1->AD1_DTINI
		cNomeVe := posicione("SA3",1,xfilial("SA3")+AD1->AD1_VEND,"A3_NOME") 
		cTextoM	:= AllTrim(AD1->AD1_XNOTA)
		cProspe := AD1->AD1_PROSPE
		cLojPro := AD1->AD1_LOJPRO
		cRevisa	:= AD1->AD1_REVISA
	Else
		conout("Nao Encontrou, AD1 ....")
	EndIf

	  oItem	:= u_ItemOport(cNrOpor)

	if !::setProperties(cNrOpor,cRevisa)
		::cNrOpor	:= cNrOpor
		::cRevisa	:= cRevisa	
		::cDescri	:= cDescri
		::cUser		:= __cUserId
		::cVend		:= cVende		//	aVend[1]
		::cNomeVend	:= cNomeVe		//	aVend[2]
		::dtini		:= cdtini
		::cProven	:= "000001"
		::cStage	:= cStage
		::cPrior	:= cPrior
		::cStatus	:= cStatus
		::cProspe	:= cProspe
		::cLojPro	:= cLojPro
		::cCodCli	:= cCod
		::cLojCli	:= cLoja
		::TextoM	:= cTextoM
		::aItens	:= oItem		//{"","","","","",0,"","",0,0,0,0,0,0,0,0,"",0,"false"}
//		::cData		:= date()
//		::cHora		:= ""
//		::nMoeda	:= nMoeda
		
	endif
return ::self


/*/{Protheus.doc} setProperties
Define as propriedades da instancia, caso ache no banco de dados
@author Daniel
@since 18/11/2016
@version undefined
@param cNrOpor, String, Código  da Oportunidade
@param cRevisa, String, Revisao da Oportunidade
@return boolean, se achou a Oporturnidade
/*/
method setProperties(cNrOpor,cRevisa,lIsList) class AD1Oportun
Local cQryItem	:= ""
Local aItem		:= {}
Local nFaz		:= 0
Local cRevisaSeek:=StrZero((Val(cRevisa)+1),2)

	DbSelectArea("AD1")
	AD1->(dbsetorder(1))
	if AD1->(dbseek(xFilial("AD1") + cNrOpor + cRevisaSeek ))
		::filial	:= xFilial("AD1")
		::cNrOpor	:= AD1->AD1_NROPOR
		::cRevisa	:= AD1->AD1_REVISA	
		::cDescri	:= AD1->AD1_DESCRI
		::cUser		:= AD1->AD1_USER
		::cVend		:= AD1->AD1_VEND
		::cNomeVend	:= posicione("SA3",1,xfilial("SA3")+AD1->AD1_VEND,"A3_NOME")
		::dtini		:= SubStr(dTos(AD1->AD1_DTINI),7,2)+"/"+SubStr(dTos(AD1->AD1_DTINI),5,2)+"/"+SubStr(dTos(AD1->AD1_DTINI),1,4)	//AD1->AD1_DTINI
		::cCodCli	:= AD1->AD1_CODCLI
		::cLojCli	:= AD1->AD1_LOJCLI
		::cProven	:= AD1->AD1_PROVEN
		::cStage	:= AD1->AD1_STAGE
		::cPrior	:= AD1->AD1_PRIOR
		::cStatus	:= AD1->AD1_STATUS
		::cProspe	:= AD1->AD1_PROSPE
		::cLojPro	:= AD1->AD1_LOJPRO
		::TextoM	:= AllTrim(AD1->AD1_XNOTA)
		  
//		::cData		:= SubStr(dTos(AD1->AD1_DATA),7,2)+"/"+SubStr(dTos(AD1->AD1_DATA),5,2)+"/"+SubStr(dTos(AD1->AD1_DATA),1,4)	//Stod(dTos(AD1->AD1_DATA))
//		::cHora		:= AD1->AD1_HORA
//		::nMoeda	:= AD1->AD1_MOEDA

		return .T.
	endif

return .F.


/*/{Protheus.doc} save
Método que grava as informações executando a rotina automáttica.
Insere e atualiza registros
@author Daniel
@since 18/11/2016
@version undefined
@return string, Se vazia ocorreu tudo certo se houver informação será o log de erros
/*/
method save() class AD1Oportun
Local aCabec	:= {}
Local cStrErro	:= ""
/*
Local aVended	:= {}
Local aAD2		:= {}	//Itens da pasta Concorrente
Local aAD3		:= {}	//Itens da pasta Time de Vendas
Local aAD4		:= {}	//Itens da pasta Parceiros
Local aAD9		:= {}	//Itens da pasta Contatos
Local aADJ		:= {}	//Itens da pasta Produtos 
Local aErroRot	:= {}
Local lRet		:= .T.
Local cNrOpor 	:= ""
Local cRevisa 	:= "" 
 
Private lMsErroAuto	:= .F.
Private lMsHelpAuto	:= .T.
Private lAutoErrNoFile	:= .T.

	dbSelectArea("AD1")
	dbSetOrder(1)

//	cNrOpor := GetNrOpor()
//	cRevisa := GetRevisa(cNrOpor)
//	aVended	:= GetVended(__cUserId)		//CUSERNAME -->> Administrador para o codigo _cUesrID="000000"

	If !dbSeek(xFilial("AD1")+cNrOpor) .and. cRevisa="01" 
		
		//Inclusão 
		aCabec:={{ "AD1_FILIAL"	, ::filial		, NIL },;
				{ "AD1_NROPOR"	, ::cNrOpor		, NIL },;
				{ "AD1_REVISA"	, ::cRevisa		, NIL },;		//trocar na revisão
				{ "AD1_DESCRI"	, ::cDescri		, NIL },;
				{ "AD1_USER  "	, ::cUser		, NIL },;
				{ "AD1_VEND  "	, ::cVend		, NIL },;
				{ "AD1_NOMVEN"	, ::cNomeVend	, NIL },;
				{ "AD1_DTINI "	, ::dtini		, NIL },;
				{ "AD1_CODCLI"	, ::cCodCli		, NIL },;
				{ "AD1_LOJCLI"	, ::cLojCli		, NIL },;
				{ "AD1_PROVEN"	, ::cProven		, NIL },;
				{ "AD1_STAGE "	, ::cStage		, NIL },;
				{ "AD1_MOEDA "	, "1"			, NIL },;
				{ "AD1_PRIOR "	, ::cPrior		, NIL },;
				{ "AD1_STATUS"	, ::cStatus		, NIL },;
				{ "AD1_PROSPE"	, ::cProspe		, NIL },;
				{ "AD1_OBSPRO"	, ::TextoM		, NIL },;
				{ "AD1_LOJPRO"	, ::cLojPro		, NIL }} 

	ElseIf cRevisa<>"01"

		//Alteração/Revisão 

		aCabec:={{ "AD1_FILIAL"	, ::filial		, NIL },;
				{ "AD1_NROPOR"	, cNrOpor		, NIL },;	//ira manter o numero da oportunidade
				{ "AD1_REVISA"	, ::cRevisa		, NIL },;	//alterado o numero no processo anterior
				{ "AD1_DESCRI"	, ::cDescri		, NIL },;
				{ "AD1_USER  "	, ::cUser		, NIL },;
				{ "AD1_VEND  "	, ::cVend		, NIL },;
				{ "AD1_NOMVEN"	, ::cNomeVend	, NIL },;
				{ "AD1_DTINI "	, ::dtini		, NIL },;
				{ "AD1_CODCLI"	, ::cCodCli		, NIL },;
				{ "AD1_LOJCLI"	, ::cLojCli		, NIL },;
				{ "AD1_PROVEN"	, ::cProven		, NIL },;
				{ "AD1_STAGE "	, ::cStage		, NIL },;
				{ "AD1_MOEDA "	, "1"			, NIL },;
				{ "AD1_PRIOR "	, ::cPrior		, NIL },;
				{ "AD1_STATUS"	, ::cStatus		, NIL },;
				{ "AD1_PROSPE"	, ::cProspe		, NIL },;
				{ "AD1_OBSPRO"	, ::TextoM		, NIL },;
				{ "AD1_LOJPRO"	, ::cLojPro		, NIL }} 
	EndIf

//			AD1>MEMO ESTÁ SENDO GRAVADO NO AD1_OBSPRO


aADJ:=		{{"ADJ_FILIAL"	, xFilial()		, NIL },;
			{ "ADJ_ITEM"	, "001"			, NIL },;
			{ "ADJ_PROD"	, "0120001"		, NIL },;
			{ "ADJ_XTABPR"	, ""			, NIL },;
			{ "ADJ_QUANT"	, 1				, NIL },;
			{ "ADJ_PRUNIT"	, 10			, NIL },;
			{ "ADJ_VALOR"	, 10			, NIL },;
			{ "ADJ_XPRCVE"	, ""			, NIL },;	
			{ "ADJ_XPRFAT"	, ""			, NIL },;	
			{ "ADJ_XFILFA"	, FilialInformada, NIL },;
			{ "ADJ_NROPOR"	, cNrOpor		, NIL },;
			{ "ADJ_REVISA"	, cRevisa		, NIL },;
			{ "ADJ_HISTOR"	, "2"			, NIL },;
			{ "ADJ_XDESCO"	, 0				, NIL },;
			{ "ADJ_XCOL"	, 0				, NIL },;
			{ "ADJ_XALT"	, 0				, NIL },;
			{ "ADJ_XFORMA"	, 0				, NIL },;
			{ "ADJ_XPAGIN"	, 0				, NIL }}

	//****************************
	//Gravacao da oportunidade
	//****************************
	If cRevisa='01'
		MSExecAuto({|x,y|FATA300(x,y)},3,aCabec,aAD2,aAD3,aAD4,aAD9,aADJ)
	Else
//		MSExecAuto({|x,y|FATA300(x,y)},4,aCabec)	// era em formato de alteração agora sera uma nova inclusão com outro numero de revisão
		MSExecAuto({|x,y|FATA300(x,y)},3,aCabec,aAD2,aAD3,aAD4,aAD9,aADJ)
	EndIf
 	If lMsErroAuto
		DisarmTransaction()
		lRet := .F.
		
		aErroRot := GetAutoGRLog()
		for ni := 1 to len(aErroRot)
			cStrErro += aErroRot[ni]
		next
	Else
		lRet := .T.
/*
//	aqui .. não executa pelo save() executa pelo Fata300My()
		conout(::aItens[1]:cproduto)
		If lRet
			DbSelectArea("ADJ")
			Reclock("ADJ",.T.)
			ADJ->ADJ_FILIAL	:= xFilial()
			ADJ->ADJ_ITEM	:= "001"
			ADJ->ADJ_NROPOR	:= cNrOpor
			ADJ->ADJ_REVISA	:= cRevisa
			ADJ->ADJ_PROD	:= "ZAPN"
			ADJ->ADJ_XTABPR	:= "002"
			ADJ->ADJ_QUANT	:= 1
			ADJ->ADJ_PRUNIT	:= 20
			ADJ->ADJ_VALOR	:= 20
			//ADJ->ADJ_XPRCVE:= "1"	
			ADJ->ADJ_XPRFAT	:= "TVF - Florianop"	
			ADJ->ADJ_XFILFA	:= FilialInformada
			ADJ->ADJ_HISTOR	:= "2"
			ADJ_XDESCO		:= 0
			ADJ_XCOL		:= 0
			ADJ_XALT		:= 0
			ADJ_XFORMA		:= 0
			ADJ_XPAGIN		:= 0
			MsUnlock()
		EndIf
EndIf
*/
	
Return cStrErro


//**************
//functions
//**************
User Function Fata300My(lPortal,oOport)
Local aCabec	:= {}
Local aVended	:= {}
Local aAD2		:= {}	//Itens da pasta Concorrente
Local aAD3		:= {}	//Itens da pasta Time de Vendas
Local aAD4		:= {}	//Itens da pasta Parceiros
Local aAD9		:= {}	//Itens da pasta Contatos
Local aADJ		:= {}	//Itens da pasta Produtos 
Local lRet		:= .T.
Local lTodosSim	:= .F.
Local xTabpr 	:= ""
Local cNrOpor 	:= ""
Local cRevisa	:= ""
Local cCodCli	:= ""
Local cLojCli	:= ""
Local cProspe	:= ""
Local cLojpro	:= ""
Local cDesc		:= ""
Local cHora		:= ""
Local cTextoM	:= ""
Local cVende	:= ""
Local cNomeVe	:= ""
Local xFilfa	:= ""
Local cxPrfat	:= ""
Local cStage	:= "" 
Local dtini		:= "01/01/2017"
Local cData		:= "01/01/2017"
Local nValor 	:= 0
Local nFaz		:= 0

Default lPortal	:= .F.
Default oOport	:= nil
 
Private lMsErroAuto := .F.
	
If ValType(oOport)<> Nil
//	criar tratativa de verificação c tem itens para executar os pontos abaixo.
//	Conout('verificando aItens na Fata300My()')
//	Conout(valtype(oOport:aitens))
//	Conout(len(oOport:aitens)) 
EndIf

If !lPortal
	cDesc := "TESTE DE ROT AUTOMATICA "
Else
	cDesc  := oOport:cDescri
	dtini  := oOport:dtini
	cProspe:= oOport:cprospe 
	cLojpro:= oOport:clojpro
	cTextoM:= oOport:TextoM
	cRevisa:= oOport:cRevisa
	cNrOpor:= oOport:cNropor
	cCodCli:= oOport:cCodCli
	cLojCli:= oOport:cLojCli
	cVende := oOport:cVend
	cNomeVe:= oOport:cNomeVend
	cStage := oOport:cStage
EndIf

// vendedor antigo obtido pelo usuario
aVended	:= GetVended(__cUserId)			//CUSERNAME -->> Administrador codigo _cUesrID="000000"

dbSelectArea("AD1")
dbSetOrder(1)

If 	Len(cNrOpor)<1 

	Conout('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&')
	conout('Teste de Inclusão sem passar Numero de Oportunidade')
	conout('Antes de passar pelas funções geradoras')
	Conout('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&')
	Conout('cNrOport:')
	conout(cNrOpor)
	Conout('cRevisa:')
	conout(cRevisa)
	Conout('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&')

//	cNrOpor := GetNrOpor()
//	cRevisa	:= GetRevisa(cNrOpor)

//	Inclusão 
aCabec:=  {;
			{"AD1_FILIAL"	, xFilial()		, NIL },;
			{ "AD1_NROPOR"	, cNrOpor		, NIL },;
			{ "AD1_REVISA"	, cRevisa		, NIL },;
			{ "AD1_DESCRI"	, cDesc			, NIL },;
			{ "AD1_USER  "	, __cUserId		, NIL },;
			{ "AD1_VEND  "	, cVende		, NIL },;	//aVended[1]
			{ "AD1_NOMVEN"	, cNomeVe		, NIL },;	//aVended[2]
			{ "AD1_DTINI "	, cTod(dtini)	, NIL },;
			{ "AD1_CODCLI"	, ccodcli		, NIL },;
			{ "AD1_LOJCLI"	, clojcli		, NIL },;
			{ "AD1_PROVEN"	, "000001"		, NIL },;
			{ "AD1_STAGE "	, cStage		, NIL },;
			{ "AD1_MOEDA "	, 1				, NIL },;
			{ "AD1_PRIOR "	, "1"			, NIL },;
			{ "AD1_XNOTA"	, cTextoM		, NIL },;
			{ "AD1_STATUS"	, "1"			, NIL };
		  } 
Else 
	//	Inclusão/Alteração-Revisão 
	Conout('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
	conout('Teste de Inclusão PASSANDO o Numero de Oportunidade')
	conout('Sem passar pelas funções geradoras!!!')
	Conout('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
	Conout('cNrOport:')
	conout(cNrOpor)
	Conout('cRevisa:')
	conout(cRevisa)
	Conout('cVende:')
	conout(cVende)
	Conout('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

	If Len(AllTrim(cProspe))<1
			aCabec:=   {;
			{"AD1_FILIAL"	, xFilial()		, NIL },;
			{ "AD1_NROPOR"	, cNrOpor		, NIL },;
			{ "AD1_REVISA"	, cRevisa		, NIL },;
			{ "AD1_DESCRI"	, cDesc			, NIL },;
			{ "AD1_USER  "	, __cUserId		, NIL },;
			{ "AD1_VEND  "	, cVende		, NIL },;	//aVended[1]
			{ "AD1_NOMVEN"	, cNomeVe		, NIL },;	//aVended[2]
			{ "AD1_DTINI "	, cTod(dtini)	, NIL },;
			{ "AD1_CODCLI"	, cCodCli		, NIL },;
			{ "AD1_LOJCLI"	, cLojCli		, NIL },;
			{ "AD1_PROVEN"	, "000001"		, NIL },;
			{ "AD1_STAGE "	, cStage		, NIL },;
			{ "AD1_MOEDA "	, 1				, NIL },;
			{ "AD1_PRIOR "	, "1"			, NIL },;
			{ "AD1_XNOTA"	, cTextoM		, NIL },;
			{ "AD1_STATUS"	, "1"			, NIL };
		   } 
	Else	//Informado um Prospect
			aCabec:=   {;
			{"AD1_FILIAL"	, xFilial()		, NIL },;
			{ "AD1_NROPOR"	, cNrOpor		, NIL },;
			{ "AD1_REVISA"	, cRevisa		, NIL },;
			{ "AD1_DESCRI"	, cDesc			, NIL },;
			{ "AD1_USER  "	, __cUserId		, NIL },;
			{ "AD1_VEND  "	, cVende		, NIL },;
			{ "AD1_NOMVEN"	, cNomeVe		, NIL },;
			{ "AD1_DTINI "	, cTod(dtini)	, NIL },;
			{ "AD1_CODCLI"	, cCodCli		, NIL },;
			{ "AD1_LOJCLI"	, cLojCli		, NIL },;
			{ "AD1_PROSPE"	, cProspe		, NIL },;
			{ "AD1_LOJPRO"	, cLojPro		, NIL },;
			{ "AD1_PROVEN"	, "000001"		, NIL },;
			{ "AD1_STAGE "	, cStage		, NIL },;
			{ "AD1_MOEDA "	, 1				, NIL },;
			{ "AD1_PRIOR "	, "1"			, NIL },;
			{ "AD1_XNOTA"	, cTextoM		, NIL },;
			{ "AD1_STATUS"	, "1"			, NIL };
		   } 
	EndIf

aADJ:=		{{"ADJ_FILIAL"	, xFilial()				 	, NIL },;
			{ "ADJ_NROPOR"	, cNrOpor					, NIL },;	//oJson:aitens[1]:cnropor
			{ "ADJ_REVISA"	, cRevisa				 	, NIL }}	//oJson:aitens[1]:crevisa

/*
aADJ:=		{{"ADJ_FILIAL"	, xFilial()					 	, NIL },;
			{ "ADJ_NROPOR"	, cNrOpor						, NIL },;	//oJson:aitens[1]:cnropor
			{ "ADJ_REVISA"	, cRevisa				 		, NIL },;	//oJson:aitens[1]:crevisa
			{ "ADJ_PROD"	, oOport:aitens[nFaz]:cproduto	, NIL },;
			{ "ADJ_XTABPR"	, oOport:aitens[nFaz]:cxtabpr	, NIL },;
			{ "ADJ_QUANT"	, oOport:aitens[nFaz]:nquant 	, NIL },;
			{ "ADJ_PRUNIT"	, oOport:aitens[nFaz]:nprunit	, NIL },;
			{ "ADJ_VALOR"	, oOport:aitens[nFaz]:nvalor 	, NIL },;
			{ "ADJ_XPRCVE"	, oOport:aitens[nFaz]:cxprcve	, NIL },;	
			{ "ADJ_XPRFAT"	, oOport:aitens[nFaz]:cxprfat	, NIL },;	
			{ "ADJ_XFILFA"	, oOport:aitens[nFaz]:cxfilfa	, NIL },;
			{ "ADJ_HISTOR"	, oOport:aitens[nFaz]:chistor	, NIL },;
			{ "ADJ_XDESCO"	, oOport:aitens[nFaz]:xdesco	, NIL },;
			{ "ADJ_XCOL"	, oOport:aitens[nFaz]:xcolun	, NIL },;
			{ "ADJ_XALT"	, oOport:aitens[nFaz]:xaltur	, NIL },;
			{ "ADJ_XFORMA"	, oOport:aitens[nFaz]:xforma	, NIL },;
			{ "ADJ_XPAGIN"	, oOport:aitens[nFaz]:xpagin	, NIL }}
*/
EndIf

If !lPortal
	lTodosSim := ApMsgNoYes( 'Confirma a inclusao [Sim p/Todos] ?' )
Else
	conout("lTodosSim x Portal")
	lTodosSim	:= .t.
EndIf

//****************************
//Gravacao da oportunidade
//****************************
If lTodosSim
	If cRevisa='01'
		MSExecAuto({|x,y|FATA300(x,y)},3,aCabec,aAD2,aAD3,aAD4,aAD9,aADJ)
	Else
		MSExecAuto({|x,y|FATA300(x,y)},4,aCabec)	// era efetuado a alteração, agora é uma nova inclusão com nova revisão
	EndIf

 	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
		lRet := .F.
	Else
		lRet := .T.
		If lRet
			If Len(oOport:aitens)>0
				For nFaz:=1 to Len(oOport:aitens)
					DbSelectArea("ADJ")
					Reclock("ADJ",.T.)
					ADJ->ADJ_FILIAL	:= xFilial()					//oOport:aitens[nFaz]:filial
					ADJ->ADJ_ITEM	:= oOport:aitens[nFaz]:citem
					ADJ->ADJ_NROPOR	:= cNrOpor						//oOport:aitens[nFaz]:cnropor
					ADJ->ADJ_REVISA	:= cRevisa						//oOport:aitens[nFaz]:crevisa
					ADJ->ADJ_PROD	:= oOport:aitens[nFaz]:cproduto
					ADJ->ADJ_XTABPR	:= oOport:aitens[nFaz]:cxtabpr	
					ADJ->ADJ_QUANT	:= oOport:aitens[nFaz]:nquant
					ADJ->ADJ_PRUNIT	:= oOport:aitens[nFaz]:nprunit
					ADJ->ADJ_VALOR	:= oOport:aitens[nFaz]:nvalor
					ADJ->ADJ_XPRCVE	:= oOport:aitens[nFaz]:cxprcve	
					ADJ->ADJ_XFILFA	:= oOport:aitens[nFaz]:cxfilfa
					ADJ->ADJ_XPRFAT	:= oOport:aitens[nFaz]:cxprfat	
					ADJ->ADJ_HISTOR	:= oOport:aitens[nFaz]:chistor
					ADJ->ADJ_XDESCO := oOport:aitens[nFaz]:nxdesco
					ADJ->ADJ_XCOL	:= oOport:aitens[nFaz]:nxcolun
					ADJ->ADJ_XALT	:= oOport:aitens[nFaz]:nxaltur
					ADJ->ADJ_XFORMA := oOport:aitens[nFaz]:nxforma
					ADJ->ADJ_XPAGIN := oOport:aitens[nFaz]:nxpagin
					ADJ->ADJ_XPRCTB := oOport:aitens[nFaz]:nxprctb
					MsUnlock()
				Next nFaz
			EndIf
		EndIf
	EndIf
EndIf

Return lRet


//**********************
//Numero da Oportunidade
//**********************
static function GetNrOpor()

	Local aAreaAD1	:= AD1->(GetArea())
	Local cCodNovo  := ""
	Local cQryNro	:= ""

	cQryNro	:= "Select Max(AD1_NROPOR) UltNumero From " + RetSqlName("AD1")
	cQryNro	+= " Where AD1_FILIAL='"+xFilial("AD1")+"'"

	cQryNro := ChangeQuery(cQryNro)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQryNro), 'QRYNUM', .F., .T.)

	cCodNovo := StrZero((Val(QRYNUM->UltNumero)+1),6)

	DbCloseArea("QRYNUM")
	RestArea(aAreaAD1)
	
return cCodNovo

//**********************
//Revisao
//**********************
static function GetRevisa(cNrOpor)
	Local cRevisa 	:= ""
	Local cQryRev	:= ""
	Local aAreaAD1	:= {}

	Default	cNrOpor	:= ""

	DbSelectArea("AD1")
	aAreaAD1 := AD1->(GetArea())

	AD1->(dbsetorder(1))
	If !dbSeek(xFilial("AD1")+cNrOpor)	//+cRevisa
		//Incluir nova do zero
		cRevisa:="01"
	Else
		//Incluir Revisão (Alteração)
		cQryRev	:= "Select Max(AD1_REVISA) UltRevisa From " + RetSqlName("AD1")
		cQryRev	+= " Where AD1_FILIAL='"+xFilial("AD1")+"' and AD1_NROPOR='"+cNrOpor+"'"

		cQryRev := ChangeQuery(cQryRev)

		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQryRev), 'QRYREV', .F., .T.)

		cRevisa := StrZero((Val(QRYREV->UltRevisa)+1),2)

		DbCloseArea("QRYREV")
	EndIf
	RestArea(aAreaAD1)

return cRevisa


//**********************
//dados do vendedor
//**********************
static function GetVended(cUserLog)
Local aVend	:= {}
Local aArea	:= GetArea()

Default cUserLog="000000"

DbSelectArea("SA3")
DbSetOrder(7)
If !DbSeek(xFilial()+cUserLog)	// .or. cUserLog='000000'
	//usuario nao cadastrado como vendedor 
	//ou ñ autorizado qdo Admin cUserLog='000000'
	aadd(aVend,"XXXXXX")
	aadd(aVend,"NOME VENEDEDOR")
Else
	aadd(aVend,SA3->A3_COD)		//A3_CODUSR
	aadd(aVend,SA3->A3_NOME)
EndIf

RestArea(aArea)

return aVend

//***********************
// alimenta array para 
// objeto de itens
//***********************
User Function ItemOport(cNrOpor)
	
Local aItens:= {"","","","","",0,"","",0,0,0,0,0,0,0,0,"",0,"false"}
Local aItem := {}
Local aXItem:= {}
Local aRet	:= {}
Local nFaz1	:= 0
Local oItem
Local oItens	

Default aItem  := {}
Default cNrOpor:= "000000"

Conout("&&-- ItemOpor(ItemOport) --&&")	
Conout(cNrOpor)	
Conout("&&-- ItemOpor(ItemOport) --&&")	
	
If cNrOpor<>"000000"
	DbSelectArea("ADJ")
	ADJ->(dbsetorder(1))

	If ADJ->(dbseek(xFilial("ADJ") + cNrOpor ))	//+ cRevisa ))
		While ADJ->(!EOF()) .and. ADJ->ADJ_NROPOR=cNrOpor //.and. ADJ->ADJ_REVISA=AD1->AD1_REVISA
			aItens[01]:= ADJ->ADJ_HISTOR
			aItens[02]:= ADJ->ADJ_ITEM
			aItens[03]:= ADJ->ADJ_NROPOR
			aItens[04]:= ADJ->ADJ_PROD
			aItens[05]:= ADJ->ADJ_REVISA
			aItens[06]:= ADJ->ADJ_XPRCVE
			aItens[07]:= ADJ->ADJ_XPRFAT
			aItens[08]:= ADJ->ADJ_XTABPR
			aItens[09]:= ADJ->ADJ_PRUNIT
			aItens[10]:= ADJ->ADJ_QUANT
			aItens[11]:= ADJ->ADJ_VALOR
			aItens[12]:= ADJ->ADJ_xDesco
			aItens[13]:= ADJ->ADJ_xCol 
			aItens[14]:= ADJ->ADJ_xAlt
			aItens[15]:= ADJ->ADJ_xForma
			aItens[16]:= ADJ->ADJ_xPagin
			aItens[17]:= ADJ->ADJ_XFILFA
			aItens[18]:= ADJ->ADJ_XPRCTB
			
			ADJ->(DbSkip())
			
			aadd(aItem,aitens)
			aItens:={"","","","","",0,"","",0,0,0,0,0,0,0,0,"",0,"false"}
		End
	Else
		//	"oportunidade inexistente" 
		conout("Nao Encontrou, ADJ (itens)....")
	EndIf
Else
//	"oportunidade inexistente"
	conout("Oportunidade 000000 ....")
EndIf

If Len(aItem)>0
	For nFaz1:=1 to Len(aItem)
		oItem	:= aItemx():new(aItem[nFaz1])
		aadd(aRet,oItem)
	Next nFaz1
	oItens	:= aRet
Else
	conout("Array de itens em branco !!")
EndIf

Return oItens


//*************************************
//gravação de alteração
//*************************************
User Function Fata300AL(lPortal,oOport)
Local lRet		:= .T.
Local lTodosSim	:= .F.
Local xTabpr 	:= ""
Local cNrOpor 	:= ""
Local cRevisa	:= ""
Local cDesc		:= ""
Local cTextoM	:= ""
Local cProdut	:= ""
Local cRevisaNew:= ""
Local cStage	:= ""
Local dtini		:= "01/01/2017"
Local nValor 	:= 0
Local nFaz		:= 0
Local cDeleta	:= "false"

Default lPortal	:= .F.
Default oOport	:= nil
 	
If !lPortal
	cDesc := "TESTE DE ROT AUTOMATICA "
EndIf

cNrOpor:= oOport:cNropor
cRevisa:= posicione("AD1",1,xfilial("AD1")+cNrOpor,"AD1_REVISA")	//	oOport:cRevisa

Conout('___________________________________________________')
Conout('Revisao na BD:')
Conout(cRevisa)
Conout('___________________________________________________')

cDesc  := oOport:cDescri
dtini  := oOport:dtini
cTextoM:= oOport:textoM
cStage := oOport:cStage

aVended	:= GetVended(__cUserId)

If !lPortal
	lTodosSim := ApMsgNoYes( 'Confirma a inclusao [Sim p/Todos] ?' )
Else
	lTodosSim	:= .t.
EndIf

//***********************************
//Gravacao da alteracao oportunidade
//***********************************
If lTodosSim
	If Len(cNrOpor)>0
		
		dbSelectArea("AD1")
		dbSetOrder(1)

		If AD1->(dbseek(xFilial("AD1") + cNrOpor + cRevisa ))

			cRevisaNew:= StrZero(val(cRevisa)+1,2)

			Reclock("AD1",.F.)
			AD1->AD1_REVISA	:= cRevisaNew 
			AD1->AD1_DESCRI	:= cDesc
			AD1->AD1_XNOTA	:= cTextoM
			AD1->AD1_STAGE	:= cStage
//			AD1->AD1_DTINI	:= dtini
			AD1->(MsUnlock())
			
			dbSelectArea("ADJ")
			dbSetOrder(1)				//ADJ_FILIAL+ADJ_NROPOR+ADJ_REVISA+ADJ_PROD
		
			Conout('___________________________________________________')
			Conout('Qtde de itens:')
			Conout(Len(oOport:aitens))
			Conout('___________________________________________________')
			For nFaz:=1 to Len(oOport:aitens)
				cProdut:= AllTrim(oOport:aitens[nFaz]:cproduto)

				//	Alteração/Revisão 
				Conout('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
				conout('Teste de ALTERACAO.............. PASSANDO o Numero de Oportunidade')
				conout('NOVA FUNCAO PARA ALTERACAO       !!!')
				Conout('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
				Conout('cNrOport:')
				conout(cNrOpor)
				Conout('cRevisa:')
				conout(cRevisa)
				Conout('cProdut:')
				conout(cProdut)
				Conout('xFilfa:')
				conout(oOport:aitens[nFaz]:cxFilfa)
				Conout('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

				If ADJ->(dbseek(xFilial("ADJ")+cNropor+cRevisa+cProdut))
					cDeleta:= oOport:aitens[nFaz]:deleta
					If cDeleta="true"
//							Deleção de Item durante a Alteração
							Reclock("ADJ",.F.)
							ADJ->(DbDelete())
							ADJ->(MsUnlock())
					Else
						If ADJ->ADJ_NROPOR = cNropor .and. ADJ->ADJ_REVISA=cRevisa .and. ADJ->ADJ_PROD=cProdut 
							Reclock("ADJ",.F.)
							ADJ->ADJ_REVISA	:= cRevisaNew						//oOport:aitens[nFaz]:crevisa
							ADJ->ADJ_XTABPR	:= oOport:aitens[nFaz]:cxtabpr	
							ADJ->ADJ_QUANT	:= oOport:aitens[nFaz]:nquant
							ADJ->ADJ_PRUNIT	:= oOport:aitens[nFaz]:nprunit
							ADJ->ADJ_VALOR	:= oOport:aitens[nFaz]:nvalor
							ADJ->ADJ_XPRCVE	:= oOport:aitens[nFaz]:cxprcve	
							ADJ->ADJ_XPRFAT	:= oOport:aitens[nFaz]:cxprfat
							ADJ->ADJ_HISTOR	:= oOport:aitens[nFaz]:chistor
							ADJ->ADJ_XDESCO := oOport:aitens[nFaz]:nxdesco
							ADJ->ADJ_XCOL	:= oOport:aitens[nFaz]:nxcolun
							ADJ->ADJ_XALT	:= oOport:aitens[nFaz]:nxaltur
							ADJ->ADJ_XFORMA := oOport:aitens[nFaz]:nxforma
							ADJ->ADJ_XPAGIN := oOport:aitens[nFaz]:nxpagin
							ADJ->ADJ_XPRCTB := oOport:aitens[nFaz]:nxprctb
							ADJ->ADJ_XFILFA	:= oOport:aitens[nFaz]:cxfilfa	
							ADJ->(MsUnlock())
						EndIf
					EndIf
				Else
//					Inclusão de Item durante a Alteração
					Reclock("ADJ",.T.)
					ADJ->ADJ_FILIAL	:= xFilial()					//oOport:aitens[nFaz]:filial
					ADJ->ADJ_ITEM	:= oOport:aitens[nFaz]:citem
					ADJ->ADJ_NROPOR	:= cNrOpor						//oOport:aitens[nFaz]:cnropor
					ADJ->ADJ_REVISA	:= cRevisaNew					//oOport:aitens[nFaz]:crevisa
					ADJ->ADJ_PROD	:= oOport:aitens[nFaz]:cproduto
					ADJ->ADJ_XTABPR	:= oOport:aitens[nFaz]:cxtabpr	
					ADJ->ADJ_QUANT	:= oOport:aitens[nFaz]:nquant
					ADJ->ADJ_PRUNIT	:= oOport:aitens[nFaz]:nprunit
					ADJ->ADJ_VALOR	:= oOport:aitens[nFaz]:nvalor
					ADJ->ADJ_XPRCVE	:= oOport:aitens[nFaz]:cxprcve	
					ADJ->ADJ_XFILFA	:= oOport:aitens[nFaz]:cxfilfa
					ADJ->ADJ_XPRFAT	:= oOport:aitens[nFaz]:cxprfat	
					ADJ->ADJ_HISTOR	:= oOport:aitens[nFaz]:chistor
					ADJ->ADJ_XDESCO := oOport:aitens[nFaz]:nxdesco
					ADJ->ADJ_XCOL	:= oOport:aitens[nFaz]:nxcolun
					ADJ->ADJ_XALT	:= oOport:aitens[nFaz]:nxaltur
					ADJ->ADJ_XFORMA := oOport:aitens[nFaz]:nxforma
					ADJ->ADJ_XPAGIN := oOport:aitens[nFaz]:nxpagin
					ADJ->ADJ_XPRCTB := oOport:aitens[nFaz]:nxprctb
					MsUnlock()
				EndIf
			Next nFaz
		EndIf
	EndIf
EndIf

Return lRet
