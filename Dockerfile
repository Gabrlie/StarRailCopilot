FROM python:3.10.10-slim



WORKDIR /app

#COPY . /app

RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list && \
    apt update && apt install -y --no-install-recommends python3-dev git adb python3-opencv gcc ffmpeg libsm6 libxext6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    git clone https://github.com/Gabrlie/StarRailCopilot . && \
    pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
    pip install --upgrade pip setuptools && \
    pip install --no-cache-dir -r requirements.txt

ARG TZ=Shanghai
ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 创建启动脚本
RUN echo '#!/bin/bash\n\
sed -i "s/GitExecutable:.*/GitExecutable: git/g" config/deploy.yaml\n\
sed -i "s/PythonExecutable:.*/PythonExecutable: python/g" config/deploy.yaml\n\
sed -i "s/AdbExecutable:.*/AdbExecutable: adb/g" config/deploy.yaml\n\
sed -i "s/Language:.*/Language: zh-CN/g" config/deploy.yaml\n\
\n\
if [ -n "$PASSWORD" ]; then\n\
  echo "Setting password from environment variable..."\n\
  sed -i "s/Password: null/Password: $PASSWORD/g" config/deploy.yaml\n\
fi\n\
\n\
python gui.py\n\
' > /app/start.sh && chmod +x /app/start.sh

LABEL version="1.1"

CMD ["/app/start.sh"]