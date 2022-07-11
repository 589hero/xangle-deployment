FROM teachablenlp/torchserve-gpu:0.6.0

RUN pip install accelerate

ARG MODEL_NAME=summary
ENV MODEL_NAME $MODEL_NAME
ARG MODEL_DOWNLOAD_LINK
ENV MODEL_DOWNLOAD_LINK $MODEL_DOWNLOAD_LINK

WORKDIR /home/model-server
RUN curl -X GET $MODEL_DOWNLOAD_LINK -o model-store/$MODEL_NAME.mar

EXPOSE 8080

CMD ["torchserve", "--start", "--ncs", "--model-store=/home/model-server/model-store", "--models=$MODEL_NAME.mar"]