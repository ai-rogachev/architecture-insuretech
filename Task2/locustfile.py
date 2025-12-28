from locust import HttpUser, between, task

class WebsiteUser(HttpUser):
    wait_time = between(0.1, 1)  # Уменьшена пауза для большей нагрузки

    @task
    def index(self):
        self.client.get("/")
    
    @task(3)  # Эта задача выполняется в 3 раза чаще
    def load_page(self):
        self.client.get("/")