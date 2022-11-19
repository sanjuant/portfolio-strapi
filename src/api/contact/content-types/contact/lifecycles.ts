function encodeBase64(string) {
    return Buffer.from(string, 'ascii').toString('base64')
}

function rot47(data) {
  const result = []
  for (let i = 0; i < data.length; i++) {
    const charCode = data.charCodeAt(i)
    if (charCode >= 33 && charCode <= 126) {
      result[i] = String.fromCharCode(33 + ((charCode + 14) % 94))
    } else {
      result[i] = String.fromCharCode(charCode)
    }
  }
  return result.join('')
}

function obfuscateString(string) {
  let result = string.split('').reverse().join('')
  result = encodeBase64(result)
  result = rot47(result)
  result = encodeBase64(result)
  return result
}

export default {
  beforeCreate: async (event) => {
    const { data } = event.params;
    if (data.email) {
      data.protectedEmail = obfuscateString(data.email);
    }
    if (data.phone) {
      data.protectedPhone = obfuscateString(data.phone);
    }
  },
  beforeUpdate: async (event) => {
    const { data } = event.params;
    if (data.email) {
      data.protectedEmail = obfuscateString(data.email);
    }
    if (data.phone) {
      data.protectedPhone = obfuscateString(data.phone);
    }
  },
};


