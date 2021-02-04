/****** Выборочная очистка РС "Цены номенклатуры опт"  ******/
/* Выберем все активные различные строки по измерениям, период которых старше или равен заданному */
/* Затем удалим из таблицы регистра все строки, полностью совпадающие по измерениям с найденными ранее и период которых меньше заданного */
/* Таким образом, в РС останутся "свежие" цены + те цены, которые в период старше заданного - не устанавливались */

USE [KRR]

GO

IF OBJECT_ID('tempdb..#VT_IS_IN_2018') IS NOT NULL DROP TABLE #VT_IS_IN_2018

--BEGIN TRAN T1;

SELECT DISTINCT
	_Fld3549RRef,
	_Fld3550RRef,
	_Fld3551,
	_Fld6255_TYPE,
	_Fld6255_RTRef,
	_Fld6255_RRRef
INTO #VT_IS_IN_Period
FROM [dbo].[_InfoRg3548]
WHERE [dbo].[_InfoRg3548]._Period >= '4017-07-01' AND [dbo].[_InfoRg3548]._Active = 0x01

DELETE TOP(500000) RgInfo

FROM [dbo].[_InfoRg3548] AS RgInfo

INNER JOIN #VT_IS_IN_Period ON

	RgInfo._Fld3549RRef = #VT_IS_IN_Period._Fld3549RRef
AND RgInfo._Fld3550RRef = #VT_IS_IN_Period._Fld3550RRef
AND RgInfo._Fld3551 = #VT_IS_IN_Period._Fld3551
AND RgInfo._Fld6255_TYPE = #VT_IS_IN_Period._Fld6255_TYPE
AND RgInfo._Fld6255_RTRef = #VT_IS_IN_Period._Fld6255_RTRef
AND RgInfo._Fld6255_RRRef = #VT_IS_IN_Period._Fld6255_RRRef
AND RgInfo._Period < '4017-07-01'

--COMMIT TRAN T1;

IF OBJECT_ID('tempdb..#VT_IS_IN_2018') IS NOT NULL DROP TABLE #VT_IS_IN_2018

