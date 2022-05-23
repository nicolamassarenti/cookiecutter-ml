from fastapi import FastAPI


app = FastAPI(
    description="{{ cookiecutter.description }}",
    version="0.1.0",
)


class Tag:
    MONITORING = "Monitorning"


@app.get(
    "/",
    status_code=200,
    description="Health probe",
    tags=[Tag.MONITORING],
)
def health():
    return 200
