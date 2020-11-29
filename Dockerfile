FROM continuumio/anaconda3:2019.03

RUN apt-get -y update && apt-get -y install vim
RUN pip install --upgrade pip && pip install autopep8

ARG project_dir=/projects
WORKDIR $project_dir
ADD requirements.txt .
RUN pip install -r requirements.txt
COPY . $project_dir
RUN pip install python-multipart && pip install uvicorn
RUN cd $project_dir/db
RUN sqlite3 $project_dir/db/proto.db < $project_dir/db/db.schema
CMD ["uvicorn", "app:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]