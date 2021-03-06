﻿Перем ИсходящиеДанные;
Перем СтрокаПравила;

// Преобразовывает имя переменной к более читабельному виду, аналогично внутренним алгоритмам 1С
// Например "ОбменСБазой" -> "Обмен с базой"
Функция ПолучитьЗаголовокПоИмени(ИмяПеременной)
	Перем МаленькиеБуквы, Цифры, Буква, Ответ, сч, ПредыдущаяБуква, СледующаяБуква;
	ИмяПеременной = СокрЛП(ИмяПеременной);
	МаленькиеБуквы = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя_";
	Цифры="0123456789.";
	Буква = Лев(ИмяПеременной, 1);
	Ответ = ""+Буква;
	Для сч=2 По СтрДлина(ИмяПеременной) Цикл
		ПредыдущаяБуква = Буква;
		Буква = Сред(ИмяПеременной, сч, 1);
		Если (Найти(МаленькиеБуквы, Буква)=0) и (Найти(МаленькиеБуквы, ПредыдущаяБуква)>0) Тогда
			СледующаяБуква = Сред(ИмяПеременной, сч+1, 1);
			Если (СледующаяБуква<>"") и (Найти(МаленькиеБуквы, СледующаяБуква)>0) Тогда
				Буква = НРег(Буква);
			КонецЕсли;
			Буква = " "+Буква;
		ИначеЕсли (Найти(Цифры, Буква)>0) и (Найти(Цифры, ПредыдущаяБуква)=0) Тогда
			Буква = " "+Буква;
		КонецЕсли;
		Ответ = Ответ + Буква;
	КонецЦикла;
	Ответ = СтрЗаменить(Ответ, "_", " ");
	Если Ответ=ИмяПеременной Тогда
		Ответ = "";
	КонецЕсли;
	Возврат Ответ;
КонецФункции

Процедура ТабличноеПоле1ЗаголовокОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Элемент.Значение = ПолучитьЗаголовокПоИмени(ЭлементыФормы.ТабОформлениеРезультата.ТекущиеДанные.ИмяКолонки);
КонецПроцедуры

Процедура ТабличноеПоле1ДанныеРасшифровкиНачалоВыбора(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	м = ТабОформлениеРезультата.ВыгрузитьКолонку("ИмяКолонки");
	Если м.Количество()=0 Тогда
		Возврат;
	КонецЕсли;
	СписокВыбора = Новый СписокЗначений;
	СписокВыбора.ЗагрузитьЗначения(м);
	Выбор = Неопределено;
	ТекЗначение = Элемент.Значение;
	Для каждого ЭлементСписка Из СписокВыбора Цикл
		Если ЭлементСписка.Значение=ТекЗначение Тогда
			Выбор = ЭлементСписка;
		КонецЕсли;
	КонецЦикла;
	Выбор = ВыбратьИзСписка(СписокВыбора, Элемент, Выбор);
	Если Выбор<>Неопределено Тогда
		Элемент.Значение = Выбор.Значение;
	КонецЕсли;
КонецПроцедуры

Функция СформироватьКод()
	
	Запрос = Новый Запрос(ТекстЗапроса);
	М = Запрос.НайтиПараметры();
	КодОформления = 
	"ИмяПравила = СтрокаПравила.Идентификатор;
	|	
	|Запрос = Новый Запрос;";
	
	ПДатыНач = ВРег(",НачПериода,НачальнаяДата,ДатаНач,НачДата,");
	ПДатыКон = ВРег(",КонПериода,КонечнаяДата,ДатаКон,КонДата,");
	Для каждого ПараметрЗапроса Из М Цикл
		ИП = ","+врег(ПараметрЗапроса.Имя)+",";
		Если Найти(ПДатыНач, ИП)>0 Тогда
			КодОформления = КодОформления + Символы.ПС + "Запрос.УстановитьПараметр("""+ПараметрЗапроса.Имя+""", НачалоДня(ДатаНач));";
		ИначеЕсли Найти(ПДатыКон, ИП)>0 Тогда
			КодОформления = КодОформления + Символы.ПС + "Запрос.УстановитьПараметр("""+ПараметрЗапроса.Имя+""", КонецДня(ДатаКон));";
		ИначеЕсли ИП=",ОРГАНИЗАЦИЯ," Тогда
			КодОформления = КодОформления + Символы.ПС + "Запрос.УстановитьПараметр(""Организация"", Организация);";
		Иначе
			КодОформления = КодОформления + Символы.ПС + СтрЗаменить("Запрос.УстановитьПараметр(""?"", ДопПараметры.?)", "?", ПараметрЗапроса.Имя)+"; //Тип: "+ПараметрЗапроса.ТипЗначения;
		КонецЕсли;
	КонецЦикла;
	КодОформления = КодОформления + " 
	|
	|Запрос.Текст = """+СтрЗаменить(СтрЗаменить(ТекстЗапроса,"""",""""""), Символы.ПС, Символы.ПС+Символы.Таб+"|")+""";
	|
	|Результат = Запрос.Выполнить();
	|
	|СтрокаПравила.ОбнаруженыОшибки  = НЕ Результат.Пустой();
	|СтрокаПравила.ПроверкаВыполнена = Истина;
	|
	|//Оформление результата
	|Если СтрокаПравила.ОбнаруженыОшибки Тогда
	|
	|	ИсходящиеДанные.Вставить(ИмяПравила+""РезультатЗапроса"", Результат);
	|
	|	СтруктураЗаголовков = Новый Структура;";
	
	Для каждого Строчка Из ТабОформлениеРезультата Цикл
		Если Строчка.ИмяКолонки=Строчка.Заголовок или ПустаяСтрока(Строчка.Заголовок) Тогда
			Продолжить;
		КонецЕсли;
		КодОформления = КодОформления + "
		|	СтруктураЗаголовков.Вставить("""+Строчка.ИмяКолонки+""", """+Строчка.Заголовок+""");";
	КонецЦикла;
	
	КодОформления = КодОформления + "
	|	ИсходящиеДанные.Вставить(ИмяПравила+""СтруктураЗаголовков"", СтруктураЗаголовков);
	|
	|	СтруктураРасшифровки = Новый Структура;";
	
	Для каждого Строчка Из ТабОформлениеРезультата Цикл
		Если ПустаяСтрока(Строчка.ДанныеРасшифровки) Тогда
			Продолжить;
		КонецЕсли;
		КодОформления = КодОформления + "
		|	СтруктураРасшифровки.Вставить("""+Строчка.ИмяКолонки+""", """+Строчка.ДанныеРасшифровки+""");";
	КонецЦикла;
	
	КодОформления = КодОформления + "
	|	ИсходящиеДанные.Вставить(ИмяПравила+""СтруктураРасшифровки"", СтруктураРасшифровки);
	|
	|	СтруктураШириныКолонок = Новый Структура;";
	
	Для каждого Строчка Из ТабОформлениеРезультата Цикл
		Если Строчка.Ширина<=0 Тогда
			Продолжить;
		КонецЕсли;
		КодОформления = КодОформления + "
		|	СтруктураШириныКолонок.Вставить("""+Строчка.ИмяКолонки+""", """+Формат(Строчка.Ширина, "ЧГ=")+""");";
	КонецЦикла;
	
	КодОформления = КодОформления + "
	|	ИсходящиеДанные.Вставить(ИмяПравила+""СтруктураШириныКолонок"", СтруктураШириныКолонок);
	|КонецЕсли;";
	
	Возврат КодОформления;
КонецФункции

Процедура КнопкаВыполнитьНажатие(Кнопка)
	Если ЭлементыФормы.Панель.ТекущаяСтраница = ЭлементыФормы.Панель.Страницы.ОформлениеРезультата Тогда
		ЭлементыФормы.КодОформления.УстановитьТекст(СформироватьКод());
		ЭлементыФормы.Панель.ТекущаяСтраница = ЭлементыФормы.Панель.Страницы.ТекстАлгоритма;
	КонецЕсли;
	ПанельПриСменеСтраницы(0, 0);
КонецПроцедуры

Процедура ПанельПриСменеСтраницы(Элемент, ТекущаяСтраница)
	кн = ЭлементыФормы.ОсновныеДействияФормы.Кнопки.ОсновныеДействияФормыВыполнить;
	кн.Доступность = (ЭлементыФормы.Панель.ТекущаяСтраница <> ЭлементыФормы.Панель.Страницы.ТекстАлгоритма);
	кн.Текст = ?(кн.Доступность, "Далее >>", " ");
КонецПроцедуры

Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	Если ТипЗнч(Результат)<>Тип("ДеревоЗначений") и ТипЗнч(Результат)<>Тип("ТаблицаЗначений") Тогда
		Предупреждение("Не задан результат запроса!");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	Для каждого Колонка Из Результат.Колонки Цикл			
		НС = ТабОформлениеРезультата.Добавить();
		НС.ИмяКолонки = Колонка.Имя;
		НС.Заголовок =  ПолучитьЗаголовокПоИмени(?(ПустаяСтрока(Колонка.Заголовок),Колонка.Имя, Колонка.Заголовок));
		НС.ДанныеРасшифровки = Колонка.Имя;
		НС.Ширина = Колонка.Ширина;
	КонецЦикла;
КонецПроцедуры

Процедура СсылкаНажатие(Элемент)
	Гиперссылка = СокрЛП(Элемент.Заголовок);
	ЗапуститьПриложение(Гиперссылка);
КонецПроцедуры
