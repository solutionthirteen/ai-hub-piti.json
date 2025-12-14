# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# install custom nodes into comfyui
# QwenVL Custom Node installieren
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/1038lab/ComfyUI-QwenVL
# TinyTerra Nodes (ttN text)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/TinyTerra/ComfyUI_tinyterraNodes
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/lrzjason/Comfyui-QwenEditUtils


# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors --relative-path models/text_encoders --filename qwen_3_4b.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors
# COPY input/ /comfyui/input/
