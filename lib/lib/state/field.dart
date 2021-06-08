class StateField {
  String? error;
  String? value;

  isValid(){
    return this.value != null && this.error == null;
  }

  setDefaultValue(String? value){
    if (this.value == null){
      this.value = value;
    }

    return this;
  }

  resetValue(){
    this.value = null;

    return this;
  }
}