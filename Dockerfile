# Use the official Python 3.11.2 image from the Docker Hub
FROM python:3.11.2

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /usr/src/code

# Install system dependencies
RUN apt-get update \
  && apt-get -y install libpq-dev gcc \
  && pip install --upgrade pip

# Copy the current directory contents into the container at /code
COPY . /usr/src/code/

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Expose port 8000 to communicate with the outside world
EXPOSE 8000

# Run the command to start uWSGI
# CMD ["python3.11.2", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["uwsgi", "--http", ":8000", "--module", "airline.wsgi:application"]

