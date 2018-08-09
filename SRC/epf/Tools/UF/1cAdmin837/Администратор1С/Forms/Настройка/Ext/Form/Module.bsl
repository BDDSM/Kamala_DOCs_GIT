﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбработкаИнформация								= Параметры.ПараметрыСеансаОбработки.КомментарийОбработки;
	
	Конфигурация 									= Параметры.ПараметрыСеансаОбработки.Конфигурация + ", версия " + Параметры.ПараметрыСеансаОбработки.Версия;
	КраткаяИнформация								= Параметры.ПараметрыСеансаОбработки.КраткаяИнформация;
	РежимСовместимости								= ""+Параметры.ПараметрыСеансаОбработки.РежимСовместимости;
	РежимСовместимостиИнтерфейса					= ""+Параметры.ПараметрыСеансаОбработки.РежимСовместимостиИнтерфейса;
	РежимИспользованияМодальности					= ""+Параметры.ПараметрыСеансаОбработки.РежимИспользованияМодальности;
	ОсновнойРежимЗапуска 							= Параметры.ПараметрыСеансаОбработки.ОсновнойРежимЗапуска;
	ТекущийРежимЗапуска 							= ""+Параметры.ПараметрыСеансаОбработки.ТекущийРежимЗапуска + ": " + Параметры.ПараметрыСеансаОбработки.ТонкийТолстый;
	БазаДанных										= Параметры.ПараметрыСеансаОбработки.СтрокаСоединенияИнформационнойБазы;
	ИмяФайлаОбработки								= Параметры.ПараметрыСеансаОбработки.ИмяФайлаОбработки;
	ТекущийПользовательИБ   						= Параметры.ПараметрыСеансаОбработки.ТекущийПользовательИБ;
	ПравоАдминистрирование							= Параметры.ПараметрыСеансаОбработки.ПравоАдминистрирование;
	ПолныеПрава										= Параметры.ПараметрыСеансаОбработки.ПолныеПрава;
	ПривилегированныйРежим							= Параметры.ПараметрыСеансаОбработки.ПривилегированныйРежим;
	ИмяРегистраДатыЗапрета							= Параметры.ПараметрыСеансаОбработки.ИмяРегистраДатыЗапрета;
	
	// ЛЕВО.
	ЭтаФорма.МонопольныйРежим						= Параметры.МонопольныйРежим;
	ЭтаФорма.ОбменДаннымиЗагрузка					= Параметры.ОбменДаннымиЗагрузка;
	//ПРАВО.
	ЭтаФорма.ПоказыватьСообщения					= Параметры.ПоказыватьСообщения;
	ЭтаФорма.СкрыватьПустыеТаблицыДвиженийРегистров	= Параметры.СкрыватьПустыеТаблицыДвиженийРегистров;
	ЭтаФорма.СкрыватьПустыеТабличныеЧасти			= Параметры.СкрыватьПустыеТабличныеЧасти;
	
	Обозначения	= "1. Значек ~ (тильда)   	- Означает ""ПОЧТИ"", например ~Предопределенный (для ПланаОбмена).
				  |2. Значек * (звездочка)	- Означает Предопределенный (например элемент Справочника).";
	
КонецПроцедуры

&НаКлиенте
Процедура МонопольныйРежимПриИзменении(Элемент)
	
	МонопольныйРежимПриИзмененииНаСервере(ЭтаФорма.МонопольныйРежим);
	
	Попытка
		Оповестить("МонопольныйРежим", ЭтаФорма.МонопольныйРежим, ЭтаФорма);
	Исключение
		Сообщить(ОписаниеОшибки(), СтатусСообщения.Информация);
	КонецПопытки;
	
	Если ЭтаФорма.МонопольныйРежим Тогда
		ПредупреждениеСообщение(, "МОНОПОЛЬНЫЙ:
		|
		|""Один пашет, а семеро руками машут."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе
		ПредупреждениеСообщение(, "МНОГОПОЛЬЗОВАТЕЛЬКИЙ ДОСТУП:
		|
		|""Один горюет, а артель воюет."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура МонопольныйРежимПриИзмененииНаСервере(Значение)
	
	Попытка
		УстановитьМонопольныйРежим(Значение);
		ЭтаФорма.МонопольныйРежим = МонопольныйРежим();
	Исключение
		Сообщить(ОписаниеОшибки(), СтатусСообщения.Информация);
		ЭтаФорма.МонопольныйРежим = МонопольныйРежим();
		Возврат;
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьСообщенияПриИзменении(Элемент)
	
	Оповестить("ПоказыватьСообщения", ЭтаФорма.ПоказыватьСообщения, ЭтаФорма);
	
	Если ЭтаФорма.ПоказыватьСообщения Тогда
		ПредупреждениеСообщение(, "ПОКАЗЫВАТЬ СООБЩЕНИЯ.
		|
		|""Свой глаз - алмаз."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "НЕ ПОКАЗЫВАТЬ СООБЩЕНИЯ.
		|
		|""Не видит око и зуб неймет."" (~ народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбменДаннымиЗагрузкаПриИзменении(Элемент)
	
	Оповестить("ОбменДаннымиЗагрузка", ЭтаФорма.ОбменДаннымиЗагрузка, ЭтаФорма);
	
	Если ЭтаФорма.ОбменДаннымиЗагрузка Тогда
		ПредупреждениеСообщение(, "ОТКЛЮЧИТЬ ТРИГГЕРЫ ЗАПИСИ (<Объект изменяемый>.ОбменДанными.Загрузка = Истина):
		|
		|Изменение значения вляет только на поведение обработки, но не на сеанс работы в 1С.
		|
		|1С: Если значение данного свойства Истина, 
		|то при выполнении записи или удаления данных будет производиться минимум проверок, 
		|так как при этом делается предположение, что производится запись данных, 
		|полученных через механизмы обмена данными, и эти данные корректны.
		|
		|Триггер (Trigger) - это особый вид хранимых процедур, автоматически выполняемых 
		|при исполнении оператора Update, Insert или Delete над данными таблицы.
		|
		|""Одна мудрая голова ста голов стоит."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "ВКЛЮЧИТЬ ТРИГГЕРЫ ЗАПИСИ (<Объект изменяемый>.ОбменДанными.Загрузка = Ложь):
		|
		|Изменение значения вляет только на поведение обработки, но не на сеанс работы в 1С.
		|
		|1С: Если значение данного свойства Истина, 
		|то при выполнении записи или удаления данных будет производиться минимум проверок, 
		|так как при этом делается предположение, что производится запись данных, 
		|полученных через механизмы обмена данными, и эти данные корректны.
		|
		|Триггер (Trigger) - это особый вид хранимых процедур, автоматически выполняемых 
		|при исполнении оператора Update, Insert или Delete над данными таблицы.
		|
		|""Одна голова хорошо, а две лучше."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СкрыватьПустыеТаблицыДвиженийРегистровПриИзменении(Элемент)
	
	Оповестить("СкрыватьПустыеТаблицыДвиженийРегистров", ЭтаФорма.СкрыватьПустыеТаблицыДвиженийРегистров, ЭтаФорма);

	Если ЭтаФорма.СкрыватьПустыеТаблицыДвиженийРегистров Тогда
		ПредупреждениеСообщение(, "НЕ ОТОБРАЖАТЬ ПУСТЫЕ ТАБЛИЦЫ ДВИЖЕНИЙ РЕГИСТРОВ.
		|
		|""С глаз долой - из сердца вон."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "ОТОБРАЖАТЬ ВСЕ ТАБЛИЦЫ ДВИЖЕНИЙ РЕГИСТРОВ (в т.ч. пустые).
		|
		|""Глаза боятся, а руки делают."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СкрыватьПустыеТабличныеЧастиПриИзменении(Элемент)
	
	Оповестить("СкрыватьПустыеТабличныеЧасти", ЭтаФорма.СкрыватьПустыеТабличныеЧасти, ЭтаФорма);

	Если ЭтаФорма.СкрыватьПустыеТабличныеЧасти Тогда
		ПредупреждениеСообщение(, "НЕ ОТОБРАЖАТЬ ПУСТЫЕ ТАБЛИЧНЫЕ ЧАСТИ.
		|
		|""С глаз долой - из сердца вон."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "ОТОБРАЖАТЬ ВСЕ ТАБЛИЧНЫЕ ЧАСТИ (в т.ч. пустые).
		|
		|""Глаза боятся, а руки делают."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура АдресНаИнфоСтарт(Команда)
	
	ЗапуститьПриложение("http://infostart.ru/public/100967/");
	
КонецПроцедуры

&НаКлиенте
Процедура ПредупреждениеСообщение(ОписаниеОповещенияОЗавершении, ТекстПредупрежденияСообщения, Таймаут = 0, Заголовок = "")
	
	Попытка
		Предупреждение(ТекстПредупрежденияСообщения, Таймаут, Заголовок);
	Исключение
		Попытка
			Выполнить("ПоказатьПредупреждение(ОписаниеОповещенияОЗавершении, ТекстПредупрежденияСообщения, Таймаут, Заголовок)");
		Исключение
			Сообщить(ТекстПредупрежденияСообщения);
		КонецПопытки;
	КонецПопытки;
		
КонецПроцедуры
