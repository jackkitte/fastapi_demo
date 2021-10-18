FROM python:3.9-buster
ENV PYTHONUNBUFFERED=1

WORKDIR /src

RUN pip install poetry

COPY pyproject.toml* poetry.lock* ./
RUN poetry export --without-hashes --dev -o requirements-dev.txt

RUN pip install --upgrade pip && pip install -r requirements-dev.txt --no-cache-dir

# uvicornのサーバーを立ち上げる
ENTRYPOINT ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]