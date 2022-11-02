FROM julia:1.8.2

WORKDIR /usr/myapp

RUN julia -e 'using Pkg; Pkg.add("IJulia"); Pkg.add("PyCall"); Pkg.add("ScikitLearn")'

RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install pipenv

COPY Pipfile.lock ./

RUN pipenv requirements > requirements.txt

RUN pip3 install -r requirements.txt

CMD ["jupyter", "lab", "--allow-root", "--no-browser", "--ip=0.0.0.0"]