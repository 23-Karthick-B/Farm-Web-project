const addProductForm = document.getElementById("add-product-form");
const updateProductForm = document.getElementById("update-product-form")

const seedbtn = document.getElementById("seeds-btn")
const fertilizerbtn = document.getElementById("fertilizers-btn")

function goToSeeds() {
    window.location.assign('/product/supplier/seeds')
}

function goToFertilizers() {
    window.location.assign('/product/supplier/fertilizers')
}


seedbtn.addEventListener('click', goToSeeds)
fertilizerbtn.addEventListener('click', goToFertilizers)

console.log(window.location);

async function postAdd(e) {
    e.preventDefault()
    const formdata = new FormData(addProductForm)
    const productData = Object.fromEntries(formdata.entries())
    console.log(productData);

    const response = await fetch(`/farmer/${username}/add-product`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(productData)
    })

    const responseData = await response.json()
    addProductForm.reset()
    document.getElementById("add-product-modal").style.display = 'none'
    window.location.assign(`/farmer/${username}`) // Refresh the page
}

async function postUpdate(e) {
    e.preventDefault()
    const formdata = new FormData(updateProductForm)
    const productData = Object.fromEntries(formdata.entries())
    console.log(productData);

    const response = await fetch(`/farmer/${username}/update-product`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(productData)
    })

    const responseData = await response.json()
    updateProductForm.reset()
    document.getElementById("update-product-modal").style.display = 'none'
    console.log(lwindow.ocation);
    window.location.assign(`/farmer/${username}`) // Refresh the page
}

addProductForm.addEventListener('submit', postAdd)
updateProductForm.addEventListener('submit', postUpdate)

// Function to handle modals
function setupModal(modalId, openBtnId) {
    const modal = document.getElementById(modalId);
    const openBtn = document.getElementById(openBtnId);
    const closeModalBtn = modal.querySelector(".close-modal");

    if (!modal || !openBtn || !closeModalBtn) return;

    openBtn.addEventListener("click", () => toggleElement(modal, true));
    closeModalBtn.addEventListener("click", () => toggleElement(modal, false));

    window.addEventListener("click", (event) => {
        if (event.target === modal) toggleElement(modal, false);
    });
}

// Function to handle sidebars (History & Supplier Panel)
function setupSidebar(sidebarId, openBtnId, closeBtnId) {
    const sidebar = document.getElementById(sidebarId);
    const openBtn = document.getElementById(openBtnId);
    const closeBtn = document.getElementById(closeBtnId);

    if (!sidebar || !openBtn || !closeBtn) return;

    openBtn.addEventListener("click", () => sidebar.classList.add("active"));
    closeBtn.addEventListener("click", () => sidebar.classList.remove("active"));
}

// Function to toggle elements
function toggleElement(element, show) {
    element.style.display = show ? "flex" : "none";
}

// Initialize modals
setupModal("add-product-modal", "add-product-btn");
setupModal("update-product-modal", "update-product-btn");
setupModal("supplier-modal", "supp-btn");

// Initialize sidebars
setupSidebar("history-bar", "history-btn", "close-history");
setupSidebar("supplier-panel", "supp-btn", "close-supplier");
