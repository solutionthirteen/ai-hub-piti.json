# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# QwenVL Custom Node installieren
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/1038lab/ComfyUI-QwenVL && \
    cd ComfyUI-QwenVL && \
    pip install --no-cache-dir -r requirements.txt

# TinyTerra Nodes (ttN text)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/TinyTerra/ComfyUI_tinyterraNodes && \
    cd ComfyUI_tinyterraNodes && \
    pip install --no-cache-dir -r requirements.txt

# Custom Scripts (ShowText)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts

# Qwen-EditUtils (TextEncodeQwenImageEdit!)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/lrzjason/Comfyui-QwenEditUtils && \
    cd Comfyui-QwenEditUtils && \
    pip install --no-cache-dir -r requirements.txt

# Easy-Use (loadImageBase64)
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/yolain/ComfyUI-Easy-Use.git && \
    pip install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-Easy-Use/requirements.txt

# Download Z-Image Turbo Models
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors --relative-path models/text_encoders --filename qwen_3_4b.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors

# Download Qwen3-VL-4B Model
RUN pip install --no-cache-dir huggingface_hub && \
    python - <<'EOF'
from huggingface_hub import snapshot_download
snapshot_download(
    repo_id="Qwen/Qwen3-VL-4B-Instruct",
    local_dir="/comfyui/models/LLM/Qwen-VL/Qwen3-VL-4B-Instruct",
    local_dir_use_symlinks=False
)
EOF
