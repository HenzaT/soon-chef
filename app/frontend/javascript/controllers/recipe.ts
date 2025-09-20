import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets: string[] = [ ('form' as const), 'button' ];
  declare readonly formTarget: HTMLElement;
  declare readonly buttonTarget: HTMLElement;

  // connect() {
  //   console.log('hello');
  // }

  openForm(): void {
    this.buttonTarget.style.display = 'none';
    this.formTarget.classList.add('visible');
    this.formTarget.scrollIntoView({ behavior: 'smooth' });
  }
}
