export function getCSRFfromHead() {
  if (process.env.NODE_ENV === 'development') {
    return "csrf_token";
  } else {
    return document.querySelector("meta[name=csrf-token]").content;
  }
}
