# 1.2. ПРИЛОЖЕНИЕ С АВТОРИЗАЦИЕЙ И ХРАНЕНИЕМ ДАННЫХ В NSUSERDEFAULTS НА ЯЗЫКЕ SWIFT
## overview
приложение с формой авторизации и хранением
данных пользователей в NSUserDefaults (UserDefaults).
## usage
используя switcher вверху экрана можно переключаться между 2 основными вкладками(UIView) приложения для регистрации и входа в свой аккаунт.
## building
Создаем проект Xcode. Убираем галочку Use Core Data, Unit tests, UI Tests и выбираем iOS – Application – Single View App. Язык - Swift.
в файл viewController.m вставляем код из репозитория. В main в контроллер добавляем объект два дополнительных UIView(можно это сделать просто скопировав основной View) и привязываем их к описанию в viewController. Так же добавляем все необходимые объекты во все UIVeiw и привязываем их к готовым описаниям в viewController.

