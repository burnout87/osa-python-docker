FROM integralsw/osa:11.0-3-g78d73880-20190124-105932-refcat-42.0

RUN yum install -y  gcc gcc-c++ make git patch openssl-devel zlib-devel readline-devel sqlite-devel bzip2-devel libffi-devel zlib python36u-tkinter.x86_64 

RUN git clone git://github.com/yyuu/pyenv.git /pyenv

RUN echo 'export PYENV_ROOT=/pyenv; export PATH="/pyenv/bin:$PATH"' >> /etc/pyenvrc && \
    echo 'eval "$(pyenv init -)"' >> /etc/pyenvrc

RUN source /etc/pyenvrc && which pyenv && pyenv install 2.7.15 && pyenv versions
RUN source /etc/pyenvrc && pyenv shell 2.7.15 && pyenv global 2.7.15 && pyenv versions && pyenv rehash

RUN echo 'source /etc/pyenvrc' >> /init.sh

RUN source /init.sh && \
    pip install numpy scipy ipython jupyter && \
    pip install git+https://github.com/threeML/threeML.git && \
    pip install git+https://github.com/threeML/astromodels.git
