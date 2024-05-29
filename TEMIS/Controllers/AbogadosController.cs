﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using TEMIS.Data;
using TEMIS.Models;
using PagedList;

namespace TEMIS.Controllers
{
    public class AbogadosController : Controller
    {
        private TEMISContext db = new TEMISContext();

        // GET: Abogados
        public ActionResult Index(string sortOrder, string filtroActual, string cadenaBuscar, int? pagina)
        {
            // parámetro de ordenamiento en el campo "Apellidos"
            // y lo enviamos a la vista
            ViewBag.ApellidoSortParam = String.IsNullOrEmpty(sortOrder) ? "apellido_desc" : "";

            //Enviar parametro "sortOrder" a la vista 
            ViewBag.OrdenamiendoActual = sortOrder;

            // parámetro de ordenamiento en el campo "DUI"
            // y lo enviamos a la vista
            ViewBag.DUISortParam = sortOrder == "dui_asc" ? "dui_desc" : "dui_asc";
            // variable para el listado de todos los doctores
            // usando LINQ
            var doctores = from s in db.Abogados select s;


            //Definir la busqueda
            if (!string.IsNullOrEmpty(cadenaBuscar))
            {
                //asignar al listado doctores el resultado de la consulta
                doctores = doctores.Where(s => s.NombreAbogado.Contains(cadenaBuscar) || s.ApellidosAbogado.Contains(cadenaBuscar) || s.EspecialidadAbogado.Contains(cadenaBuscar));
            }

            //definir la paginacion
            if (cadenaBuscar != null)
            {
                pagina = 1;
            }
            else
            {
                cadenaBuscar = filtroActual;
            }
            //definir otro parametro de busqueda para  enviarlo a la vista
            ViewBag.FiltroActual = cadenaBuscar;




            switch (sortOrder)
            {
                // ordenamiento descendente por "Apellidos"
                case "apellido_desc":
                    doctores = doctores.OrderByDescending(s => s.ApellidosAbogado);
                    break;

                // ordenamiento descendente por "DUI"
                case "dui_desc":
                    doctores = doctores.OrderByDescending(s => s.DUIAbogado);
                    break;

                // ordenamiento ascendente por "DUI"
                case "dui_asc":
                    doctores = doctores.OrderBy(s => s.DUIAbogado);
                    break;

                // ordenamiento ascendente por "Apellidos"
                default:
                    doctores = doctores.OrderBy(s => s.ApellidosAbogado);
                    break;
            }
            //definir el tamaño de la pagina y la cantidad de paginas
            int PageSize = 3;
            int PageNumber = (pagina ?? 1);

            //return View(db.Doctors.ToList());
            //return View(doctores.ToList()); Ya no se puede usar este return
            return View(doctores.ToPagedList(PageNumber, PageSize));
        }

        // GET: Abogados/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Abogados abogados = db.Abogados.Find(id);
            if (abogados == null)
            {
                return HttpNotFound();
            }
            return View(abogados);
        }

        // GET: Abogados/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Abogados/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID_Abogados,NombreAbogado,ApellidosAbogado,DUIAbogado,EspecialidadAbogado,TelefonoAbogado,EmailAbogado,CSJ")] Abogados abogados)
        {
            if (ModelState.IsValid)
            {
                db.Abogados.Add(abogados);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(abogados);
        }

        // GET: Abogados/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Abogados abogados = db.Abogados.Find(id);
            if (abogados == null)
            {
                return HttpNotFound();
            }
            return View(abogados);
        }

        // POST: Abogados/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID_Abogados,NombreAbogado,ApellidosAbogado,DUIAbogado,EspecialidadAbogado,TelefonoAbogado,EmailAbogado,CSJ")] Abogados abogados)
        {
            if (ModelState.IsValid)
            {
                db.Entry(abogados).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(abogados);
        }

        // GET: Abogados/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Abogados abogados = db.Abogados.Find(id);
            if (abogados == null)
            {
                return HttpNotFound();
            }
            return View(abogados);
        }

        // POST: Abogados/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Abogados abogados = db.Abogados.Find(id);
            db.Abogados.Remove(abogados);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}