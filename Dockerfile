FROM python:3.10.10-slim

WORKDIR /app

COPY . /app

RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list && \
    apt update && apt install -y --no-install-recommends python3-dev git adb python3-opencv && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 使用环境变量 TZ 设置时区
ARG TZ=UTC
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
if [ ! -f "/app/.dependencies_installed" ]; then\n\
  echo "Installing dependencies..."\n\
  pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple\n\
  pip install --upgrade pip setuptools\n\
  pip install --no-cache-dir -r requirements.txt\n\
  touch /app/.dependencies_installed\n\
else\n\
  echo "Dependencies already installed."\n\
fi\n\
\n\
python gui.py\n\
' > /app/start.sh && chmod +x /app/start.sh

CMD ["/app/start.sh"]