<template>
  <div class="component-upload-image">
    <el-upload
      :action="uploadImgUrl"
      list-type="picture-card"
      :on-success="handleUploadSuccess"
      :before-upload="handleBeforeUpload"
      :on-error="handleUploadError"
      :headers="headers"
      multiple
      ref="pictureUpload"
    >
      <i slot="default" class="el-icon-plus"></i>
      <div slot="file" slot-scope="{file}">
        <img
          class="el-upload-list__item-thumbnail"
          :src="file.url" alt=""
        >
        <span class="el-upload-list__item-actions">
        <span
          class="el-upload-list__item-preview"
          @click="handlePictureCardPreview(file)"
        >
          <i class="el-icon-zoom-in"></i>
        </span>
        <span
          v-if="!disabled"
          class="el-upload-list__item-delete"
          @click="handleRemove(file)"
        >
          <i class="el-icon-delete"></i>
        </span>
      </span>
      </div>
    </el-upload>
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>
  </div>
</template>

<script>
import {getToken} from "@/utils/auth";

export default {
  data() {
    return {
      dialogImageUrl: '',
      uploadImgUrl: process.env.VUE_APP_BASE_API + "/common/upload", // 上传的图片服务器地址
      dialogVisible: false,
      disabled: false,
      headers: {
        satoken: getToken(),
      },
      arrayImage:[]
    };
  },
  methods: {
    handleRemove(file) {
      // ⭐ 获取到该组件调用handleRemove方法删除file对象
      this.$refs.pictureUpload.handleRemove(file)
      for (let i = 0; i < this.arrayImage.length; i++) {
        if (file.response.data == this.arrayImage[i]){
          this.arrayImage.splice(this.arrayImage[i],1);
        }
      }
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    handleUploadSuccess(res) {
      this.arrayImage.push(res.data)
      this.$emit("input", this.arrayImage);
      this.loading.close();
    },
    handleBeforeUpload() {
      this.loading = this.$loading({
        lock: true,
        text: "上传中",
        background: "rgba(0, 0, 0, 0.7)",
      });
    },
    handleUploadError() {
      this.$message({
        type: "error",
        message: "上传失败",
      });
      this.loading.close();
    }
  }
}
</script>
