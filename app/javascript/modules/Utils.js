export function getCSRFfromHead() {
  if (['development', 'test'].includes(process.env.NODE_ENV)) {
    return "csrf_token";
  } else {
    return document.querySelector("meta[name=csrf-token]").content;
  }
}
