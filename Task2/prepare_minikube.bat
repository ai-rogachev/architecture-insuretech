@echo off
REM ============================================
REM Скрипт подготовки Minikube для тестирования
REM ============================================

echo Запуск Minikube с metrics-server...
minikube start --addons=metrics-server

REM Если Minikube уже был запущен без metrics-server, активируем его отдельно
if errorlevel 1 (
    echo Minikube уже запущен, активируем metrics-server отдельно...
    minikube addons enable metrics-server
)

echo.
echo Загрузка последнего образа тестового приложения...
docker pull ghcr.io/yandex-practicum/scaletestapp:latest

echo.
echo Применение манифестов Kubernetes...
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml

echo.
echo ============================================
echo Настройка завершена!
echo ============================================
echo.
echo Для настройки venv и работы с locust выполните следующие шаги:
echo.
echo 1. Установите virtualenv (если еще не установлен):
echo    pip install virtualenv
echo.
echo 2. Создайте виртуальное окружение:
echo    virtualenv venv
echo.
echo 3. Активируйте виртуальное окружение:
echo    venv\Scripts\activate
echo.
echo 4. Установите locust:
echo    pip install locust
echo.
echo 5. Проверьте установку:
echo    locust --version
echo.
echo 6. Запустите locust:
echo    Вариант 1: Получите URL и запустите вручную:
echo       minikube service scale-app-service --url
echo       locust --host=^<URL^> -f locustfile.py
pause
