from ..app import app

def test_get_time():
    with app.test_client() as client:
        response = client.get("/time")
        assert response.status_code == 200
        data = response.get_json()
        assert "time" in data
        assert isinstance(data["time"], int)
        assert data["time"] > 0
